import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_social_app/models/social_message_model.dart';
import 'package:udemy_social_app/models/social_user_model.dart';
import 'package:udemy_social_app/shared/cubit/cubit.dart';
import 'package:udemy_social_app/shared/cubit/state.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({Key? key, this.userModel}) : super(key: key);

  SocialUserModel? userModel;
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext contetxt) {
      SocialCubit.get(context).getMessage(receiverId: userModel!.uId!);

      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: CachedNetworkImageProvider(
                      '${userModel!.image}',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${userModel!.name}',
                              style: TextStyle(
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Active',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.2,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.videocam,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.call,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.info,
                    ),
                  ),
                ],
              ),
              titleSpacing: 0,
              elevation: 1,
            ),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).messages.isNotEmpty,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var messages =
                                SocialCubit.get(context).messages[index];

                            if (SocialCubit.get(context).model!.uId ==
                                messages.senderId)
                              return buildSenderMessage(messages);

                            return buildReceiverMessage(messages);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: SocialCubit.get(context).messages.length),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: TextFormField(
                                controller: textController,
                                decoration: InputDecoration(
                                  hintText: 'Type your message here ...',
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            color: Colors.deepPurple,
                            child: MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                  receiverId: userModel!.uId!,
                                  dateTime: DateTime.now().toString(),
                                  text: textController.text,
                                );
                                textController.clear();
                              },
                              minWidth: 1,
                              child: Icon(
                                Icons.send,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var messages =
                                SocialCubit.get(context).messages[index];

                            if (SocialCubit.get(context).model!.uId ==
                                messages.senderId)
                              return buildSenderMessage(messages);

                            return buildReceiverMessage(messages);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: SocialCubit.get(context).messages.length),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: TextFormField(
                                controller: textController,
                                decoration: InputDecoration(
                                  hintText: 'Type your message here ...',
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            color: Colors.deepPurple,
                            child: MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                  receiverId: userModel!.uId!,
                                  dateTime: DateTime.now().toString(),
                                  text: textController.text,
                                );
                                textController.clear();
                              },
                              minWidth: 1,
                              child: Icon(
                                Icons.send,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildSenderMessage(SocialMessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              bottomEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            model.text!,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget buildReceiverMessage(SocialMessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            model.text!,
          ),
        ),
      );
}
