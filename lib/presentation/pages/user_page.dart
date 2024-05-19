import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_concept/domain/blocs/user/user_bloc.dart';
import 'package:todo_concept/domain/blocs/user/user_event.dart';
import 'package:todo_concept/domain/blocs/user/user_state.dart';
import 'package:todo_concept/domain/models/user.dart';
import 'package:todo_concept/domain/shared/app_strings.dart';
import 'package:todo_concept/presentation/pages/todo_page.dart';

class UserPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.list, color: Colors.white),
        backgroundColor: const Color(0xff3556ab),
        title: const Text(
          AppStrings.userPageTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoadSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TodoPage()),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 30),
                child: Text(
                  AppStrings.userPageSubTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.enterNamePrompt,
                    hintText: AppStrings.enterNameHint,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.enterEmailPrompt,
                    hintText: AppStrings.enterEmailHint,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  AppStrings.userDatahint,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final user = User(
                        name: _nameController.text,
                        email: _emailController.text,
                      );
                      context.read<UserBloc>().add(SaveUser(user));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3556ab),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5.0), // Add rounded corners
                      ),
                    ),
                    child: const Text(
                      AppStrings.saveText,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
