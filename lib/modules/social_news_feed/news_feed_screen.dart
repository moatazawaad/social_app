import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_social_app/models/social_post_model.dart';
import 'package:udemy_social_app/shared/cubit/cubit.dart';
import 'package:udemy_social_app/shared/cubit/state.dart';

class NewsFeedScreen extends StatelessWidget {
  NewsFeedScreen({Key? key}) : super(key: key);

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty &&
              SocialCubit.get(context).model != null,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            'https://img.freepik.com/free-photo/smiling-happy-indian-student-with-backpack-pointing-his-finger-wall_496169-1532.jpg?w=740&t=st=1667309746~exp=1667310346~hmac=ae8bfe6dcb4edbd8c8ad70e70ca5b592754d0ec59ed54653caa791c99930e111',
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate with friends',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                    SocialCubit.get(context).posts[index],
                    context,
                    index,
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildPostItem(SocialPostModel postModel, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        CachedNetworkImageProvider('${postModel.image}'),
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
                              '${postModel.name}',
                              style: TextStyle(
                                height: 1.2,
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.deepPurpleAccent,
                              size: 16,
                            ),
                          ],
                        ),
                        Text(
                          '${postModel.dateTime}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.2,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_horiz),
                    splashRadius: 20,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[400],
                ),
              ),
              Text(
                '${postModel.postText}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     bottom: 5,
              //     top: 5,
              //   ),
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(
              //             end: 10,
              //           ),
              //           child: SizedBox(
              //             height: 25,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#software_development',
              //                 style:
              //                     Theme.of(context).textTheme.caption!.copyWith(
              //                           color: Colors.deepPurpleAccent,
              //                         ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(
              //             end: 10,
              //           ),
              //           child: SizedBox(
              //             height: 25,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#software_engineering',
              //                 style:
              //                     Theme.of(context).textTheme.caption!.copyWith(
              //                           color: Colors.deepPurpleAccent,
              //                         ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if (postModel.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 10,
                  ),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        5.0,
                      ),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          '${postModel.postImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.message_outlined,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '0 Comments',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 5,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[400],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: CachedNetworkImageProvider(
                      '${SocialCubit.get(context).model!.image}',
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              // SocialCubit.get(context).commentPost(
                              //   text: textController.text,
                              // );
                            },
                            icon: Icon(
                              Icons.send,
                            ),
                            iconSize: 20,
                          ),
                          hintText: 'Write a comment ...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 1,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      );
}
