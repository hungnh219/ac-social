import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/presentation/screens/profile_and_setting/widgets/collection_tab.dart';
import 'package:social_app/presentation/screens/profile_and_setting/widgets/information_box.dart';
import 'package:social_app/presentation/screens/profile_and_setting/widgets/shot_tab.dart';
import 'package:social_app/utils/styles/colors.dart';

import '../../../domain/entities/collection.dart';
import '../../../domain/entities/user.dart';
import '../../../utils/constants/icon_path.dart';
import '../../../utils/constants/image_path.dart';
import '../../../utils/styles/themes.dart';
import '../../widgets/edit_profile/bottom_rounded_appbar.dart';
import 'cubit/profile_cubit.dart';
import 'cubit/profile_state.dart';


const urls = [
  'https://loremflickr.com/200/200?random=1',
  'https://images.pexels.com/photos/2486168/pexels-photo-2486168.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  'https://loremflickr.com/200/200?random=5',
  'https://loremflickr.com/200/200?random=9',
  'https://loremflickr.com/200/200?random=1',
  'https://images.pexels.com/photos/2486168/pexels-photo-2486168.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  'https://loremflickr.com/200/200?random=5',
  'https://loremflickr.com/200/200?random=9',
  'https://loremflickr.com/200/200?random=1',
  'https://images.pexels.com/photos/2486168/pexels-photo-2486168.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  'https://loremflickr.com/200/200?random=5',
  'https://loremflickr.com/200/200?random=9',
];

class ProfilePart extends StatefulWidget {
  const ProfilePart({super.key});

  @override
  State<ProfilePart> createState() => _ProfilePartState();
}

class _ProfilePartState extends State<ProfilePart>
    with SingleTickerProviderStateMixin {
  int numberOfShots = 10;
  int numberOfCollections = 10;

  double avatarRadius = 50;
  late double appBarBackgroundHeight = avatarRadius * 2 / 0.6;
  late double appBarContainerHeight = avatarRadius * (1 + 2 / 0.6);

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  late TabController _tabController;

  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier(0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _onTabChanged();
    });
  }



  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _selectedIndexNotifier.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _onTabChanged() {
    _selectedIndexNotifier.value = _tabController.index;
  }

  void _onTabSelected(int index) {
    _tabController.animateTo(index);
    _selectedIndexNotifier.value = index; // Update ValueNotifier
  }

  void toggleContainer() {
    setState(() {
      if (isDrawerOpen) {
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
        isDrawerOpen = false;
      } else {
        xOffset = 330;
        yOffset = 120;
        scaleFactor = 0.7;
        isDrawerOpen = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if (isDrawerOpen) {
          toggleContainer(); // Tap anywhere to enlarge when smaller
        }
      },
      child: AnimatedContainer(
        curve: Curves.easeIn,
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateY(isDrawerOpen ? -0.5 : 0),
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
        child: DefaultTabController(
          length: 2,
          child: BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else if (state is ProfileLoaded) {

              final UserModel userModel = state.userModel;
              final List<CollectionModel> userCollections = state.collections;
              return NestedScrollView(
                physics: isDrawerOpen ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          //ToDo : AppBar Background
                          SizedBox(
                            height: appBarContainerHeight,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: SizedBox(
                                    height: appBarBackgroundHeight,
                                    child: const BottomRoundedAppBar(
                                      bannerPath:
                                          AppImages.editProfileAppbarBackground,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: IntrinsicHeight(
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            onPressed: () {
                                              if (!isDrawerOpen) {
                                                toggleContainer(); // Tap anywhere to enlarge when smaller
                                              }
                                            },
                                            icon: SvgPicture.asset(
                                              AppIcons.setting,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '@brunopham',
                                            textAlign: TextAlign.center,
                                            style: AppTheme.profileTagStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: avatarRadius * 2,
                                    height: avatarRadius * 2,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.white,
                                        width: 6.0,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          child: CircleAvatar(
                                            // 0.6 Appbar Background
                                            radius: avatarRadius,
                                            backgroundImage: CachedNetworkImageProvider(userModel.avatar),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //ToDo : Profile Information
                          IgnorePointer(
                            ignoring: isDrawerOpen,
                            child: InformationBox(userModel: userModel,
                            userFollowers: state.userFollowers,
                              userFollowings: state.userFollowings,
                            ),
                          ),

                          //TODO : Nested Tab
                          IgnorePointer(
                            ignoring: isDrawerOpen,
                            child: SizedBox(
                              width: deviceWidth * 0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ProfileTab(
                                    index: 0,
                                    selectedIndexNotifier: _selectedIndexNotifier,
                                    label: '$numberOfShots Shots',
                                    onTabSelected: _onTabSelected,
                                  ),
                                  ProfileTab(
                                    index: 1,
                                    selectedIndexNotifier: _selectedIndexNotifier,
                                    label: '${userCollections.length} Collections',
                                    onTabSelected: _onTabSelected,
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    )
                  ];
                },
                body: IgnorePointer(
                  ignoring: isDrawerOpen,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: deviceWidth * 0.07,
                        right: deviceWidth * 0.07,
                        top: 8,
                        bottom: deviceWidth * 0.15),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Shots Tab Content
                        const ShotTab(imageUrls: urls),

                        // Collections Tab Content
                        CollectionTab(collections: userCollections,)
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          }),
        ),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  final int index;
  final ValueNotifier<int> selectedIndexNotifier; // Changed to ValueNotifier
  final String label;
  final Function(int) onTabSelected;

  const ProfileTab({
    super.key,
    required this.index,
    required this.selectedIndexNotifier,
    required this.label,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<int>(
        valueListenable: selectedIndexNotifier,
        builder: (context, selectedIndex, child) {
          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: Container(
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? AppColors.foundationWhite
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: AppTheme.profileTabStyle.copyWith(
                  color: selectedIndex == index
                      ? AppColors.iris
                      : AppColors.noghreiSilver,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
