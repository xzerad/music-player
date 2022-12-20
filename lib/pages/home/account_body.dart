import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/components/account_option_button.dart';
import 'package:music_player/configurations/no_scroll_indication.dart';
import 'package:music_player/services/theme_mode_cubit.dart';

class AccountBody extends StatefulWidget {
  const AccountBody({Key? key}) : super(key: key);

  @override
  State<AccountBody> createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
  bool darkModeOn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    darkModeOn = context.read<ThemeModeCubit>().state.runtimeType == DarkMode;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: ScrollConfiguration(
        behavior: NoScrollIndication(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Account", style: textTheme.displayLarge?.copyWith(fontSize: 34),),
              const SizedBox(height: 20,),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                foregroundImage: Image.asset("assets/avatar.jpg").image,
              ),
              Text("Xzerad", style: textTheme.displayLarge,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Dark Mode", style: textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),),
                      trailing: Switch(value: darkModeOn, onChanged: (v){
                        if(v){
                          context.read<ThemeModeCubit>().setDarkMode();
                        }else{
                          context.read<ThemeModeCubit>().setBrightMode();
                        }
                        setState(() {
                              darkModeOn = v;
                            });
                      }),
                    ),
                    AccountOptionButton(icon: Icon(Icons.supervisor_account_rounded, color: Colors.white, size: 30,), title: "Edit profile",),
                    AccountOptionButton(icon: Icon(Icons.language, color: Colors.white, size: 30,), title: "Change language",),
                    AccountOptionButton(icon: Icon(Icons.devices_rounded, color: Colors.white, size: 30,), title: "My devices",),
                    AccountOptionButton(icon: Icon(Icons.delete_outline_rounded, color: Colors.white, size: 30,), title: "Delete Account",)

                  ],
                ),
              ),
              const SizedBox(height: 140,)
            ],
          ),
        ),
      ),
    );
  }
}
