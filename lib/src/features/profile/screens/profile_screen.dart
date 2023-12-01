import 'package:app_nib/src/features/profile/profile_store.dart';
import 'package:app_nib/src/shared/models/user.dart';
import 'package:app_nib/src/shared/services/http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
            TextButton(onPressed: () async {
              final picker = ImagePicker();
              final image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                final formData = FormData.fromMap({
                  'avatar': await MultipartFile.fromFile(image.path, filename: image.name),
                });
                final response = await context.read<HttpService>().client.post('/user/me/update-avatar', data: formData);
                profileStore.updateUser(response.data);

              }
            }, child: Text('Escolher imagem')),
            Row(
              children: [
                Checkbox(value: user.isAlreadyBaptized, onChanged: profileStore.onChangeAlredyBaptized),
                const Text('Sou Batizado')
              ],
            ),
            Row(
              children: [
                Checkbox(value: user.alreadyAcceptedTerm, onChanged: profileStore.onChangeAlredyAcceptedTerm),
                const Text('Já assinei a ficha de compromisso de membro')
              ],
            ),
            Text('Nome: ${user.name}'),
            Text('E-mail: ${user.email}'),
            Text('Telefone: (92) 9 9999-9999'),
            Text('Sexo: Masculino'),
            Text('Data Nascimento: 23/11/1998 (25 ANOS)'),
          ],
        ),
      ),
    );
  }
}
