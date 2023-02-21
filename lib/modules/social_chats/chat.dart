import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_social_app/models/social_user_model.dart';
import 'package:udemy_social_app/modules/social_chat_details/chat_details.dart';
import 'package:udemy_social_app/shared/components/components.dart';
import 'package:udemy_social_app/shared/cubit/cubit.dart';
import 'package:udemy_social_app/shared/cubit/state.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users!.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildChatItem(
              context,
              SocialCubit.get(context).users![index],
            ),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
              ),
              child: Container(
                height: 0,
              ),
            ),
            itemCount: SocialCubit.get(context).users!.length,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildChatItem(context, SocialUserModel model) => InkWell(
        onTap: () {
          navigateTo(
              context,
              ChatDetailsScreen(
                userModel: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: CachedNetworkImageProvider(
                  '${model.image}',
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
                          '${model.name}',
                          style: TextStyle(
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Today',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            height: 1.2,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
