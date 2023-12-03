import 'package:app_nib/src/commons/utils/toask.dart';
import 'package:app_nib/src/features/profile/profile_store.dart';
import 'package:app_nib/src/shared/auth/auth_service.dart';
import 'package:app_nib/src/shared/models/user.dart';
import 'package:app_nib/src/shared/widgets/custom_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    final store = context.read<ProfileStore>();
    store.loadUser();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      store.addListener(() {
        final error = store.getError()!;
        if (store.isError && error.isNotEmpty) {
          Toast.error(error).show(context);
        } else if (store.isSuccess) {
          Toast.success('Usuário atualizado com successo').show(context);
        }
        store.resetState();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileStore = context.watch<ProfileStore>();
    final user = profileStore.user;

    late Widget avatar;
    if (user.avatar == null) {
      String path = user.gender == UserGender.male ? 'assets/avatars/default-men.jpg' : 'assets/avatars/default-woman.jpg';
      avatar = Image.asset(path, fit: BoxFit.cover);
    } else {
      avatar = Image.network(user.avatar!, fit: BoxFit.cover);
    }

    final phoneFormatter = MaskTextInputFormatter(
      mask: '(##) 9 ####-####',
      type: MaskAutoCompletionType.eager,
      initialText: user.phone,
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: profileStore.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 150,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade500, width: 4.5),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.75), offset: const Offset(0, 1), blurRadius: 3)
                        ],
                      ),
                      child: avatar,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Matrícula',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            user.enrollmentNumber,
                            style: const TextStyle(fontSize: 22),
                          ),
                          SizedBox(
                              width: 80,
                              child: Divider(
                                color: Colors.grey.shade300,
                              )),
                          Text(
                            'ATIVO',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.green.shade400,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                Row(
                  children: [
                    if (user.avatar == null) const Icon(Icons.warning_amber_rounded, color: Colors.amber),
                    TextButton(onPressed: profileStore.updateAvatar, child: const Text('Alterar Foto')),
                  ],
                ),
                CustomCheckBox(
                  value: user.isAlreadyBaptized,
                  label: 'Sou Batizado',
                  onChanged: profileStore.onChangeAlredyBaptized,
                ),
                CustomCheckBox(
                  value: user.alreadyAcceptedTerm,
                  label: 'Já assinei a ficha de compromisso de membro',
                  onChanged: profileStore.onChangeAlredyAcceptedTerm,
                ),
                CustomTextFormField(
                  labelText: 'Nome',
                  border: const UnderlineInputBorder(),
                  initialValue: user.name,
                  onChanged: profileStore.onChangeName,
                ),
                CustomTextFormField(
                  initialValue: user.email,
                  labelText: 'E-mail',
                  validator: (value) => profileStore.getError('email'),
                  border: const UnderlineInputBorder(),
                  onChanged: profileStore.onChangeEmail,
                ),
                CustomTextFormField(
                  initialValue: phoneFormatter.maskText('${user.phone}'),
                  labelText: 'Telefone',
                  hint: '(12) 9 3456-7890',
                  border: const UnderlineInputBorder(),
                  onChanged: profileStore.onChangePhone,
                  validator: (value) => profileStore.getError('phone'),
                  formatter: phoneFormatter,
                ),
                DropdownButtonFormField<UserGender>(
                  decoration: const InputDecoration(
                    labelText: "Sexo",
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    border: UnderlineInputBorder(),
                  ),
                  itemHeight: 50,
                  onChanged: profileStore.onChangeGender,
                  items: _getGenderOption(),
                  value: user.gender,
                ),
                CustomTextFormField(
                  labelText: 'Senha',
                  obscureText: true,
                  controller: profileStore.passwordController,
                  border: const UnderlineInputBorder(),
                  validator: (value) {
                    if (value == null || value.isEmpty) return null;
                    if (value.length < 8) {
                      return 'Senha muito fraca';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () async {
                          final newDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2010, 12, 31),
                            currentDate: user.birth,
                          );
                          if (newDate != null) {
                            profileStore.onChangeBirth(newDate);
                          }
                        },
                        icon: const Icon(Icons.calendar_month),
                        label: Text(profileStore.formattedDate),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '(${DateTime.now().difference(user.birth).inDays ~/ 365} Anos)',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 64),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: profileStore.isLoading
                        ? const ElevatedButton(
                            onPressed: null,
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: profileStore.onSubmit,
                            child: const Text('Atualizar'),
                          ),
                  ),
                ),
                TextButton(onPressed: context.read<AuthService>().logout, child: const Text('Sair'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<UserGender>> _getGenderOption() {
    return UserGender.values.map(_mapperUserGenderToDropDownOption).toList();
  }

  DropdownMenuItem<UserGender> _mapperUserGenderToDropDownOption(UserGender gender) {
    return DropdownMenuItem(value: gender, child: Text(gender.label));
  }
}

class CustomCheckBox extends StatelessWidget {
  CustomCheckBox({super.key, required this.value, required this.label, required this.onChanged});

  final bool value;
  final String label;
  final Function(bool?) onChanged;
  final recognized = TapGestureRecognizer();

  @override
  Widget build(BuildContext context) {
    recognized.onTap = () => onChanged(!value);

    return SizedBox(
      height: 32,
      child: Row(
        children: [
          Checkbox(value: value, onChanged: onChanged),
          Text.rich(
            TextSpan(
              text: label,
              recognizer: recognized,
            ),
          )
        ],
      ),
    );
  }
}
