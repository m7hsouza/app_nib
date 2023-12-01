import 'package:app_nib/src/features/profile/profile_store.dart';
import 'package:app_nib/src/shared/models/user.dart';
import 'package:app_nib/src/shared/widgets/custom_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
    context.read<ProfileStore>().loadUser();
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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade500, width: 4.5), borderRadius: BorderRadius.circular(6), boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.75), offset: const Offset(0, 1), blurRadius: 3)
                    ]),
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
              const CustomTextFormField(
                labelText: 'Nome',
                border: UnderlineInputBorder(),
              ),
              const CustomTextFormField(
                labelText: 'E-mail',
                border: UnderlineInputBorder(),
              ),
              const CustomTextFormField(
                labelText: 'Telefone',
                border: UnderlineInputBorder(),
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Sexo",
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  border: UnderlineInputBorder(),
                ),
                itemHeight: 50,
                onChanged: (value) {},
                items: _getGenderOption(),
              ),
              const CustomTextFormField(
                labelText: 'Data de Nascimento',
                
                border: UnderlineInputBorder(),
              ),
   
              const Text('Data Nascimento: 23/11/1998 (25 ANOS)'),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> _getGenderOption() {
    return UserGender.values.map<DropdownMenuItem>(_mapperUserGenderToDropDownOption).toList();
  }

  DropdownMenuItem _mapperUserGenderToDropDownOption(UserGender gender) {
    return DropdownMenuItem(value: gender.toString(), child: Text(gender.label));
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
