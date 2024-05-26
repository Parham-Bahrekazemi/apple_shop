import 'dart:ui';

import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/comment/comment_bloc.dart';
import 'package:apple_shop/bloc/comment/comment_event.dart';
import 'package:apple_shop/bloc/comment/comment_state.dart';
import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:apple_shop/constants/colors.dart';

import 'package:apple_shop/data/model/category_model.dart';
import 'package:apple_shop/data/model/gallery_model.dart';
import 'package:apple_shop/data/model/product_model.dart';
import 'package:apple_shop/data/model/product_properties_model.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/variant_model.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:apple_shop/utils/custom_loading.dart';
import 'package:apple_shop/utils/extentions/int_extention.dart';
import 'package:apple_shop/utils/extentions/string_extention.dart';
import 'package:apple_shop/widgets/cached_network_iamge.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailBloc>(
      create: (context) {
        return ProductDetailBloc();
      },
      child: DetailContentWidget(
        parentWidget: widget,
      ),
    );
  }
}

class DetailContentWidget extends StatefulWidget {
  const DetailContentWidget({
    super.key,
    required this.parentWidget,
  });

  final ProductDetailScreen parentWidget;

  @override
  State<DetailContentWidget> createState() => _DetailContentWidgetState();
}

class _DetailContentWidgetState extends State<DetailContentWidget> {
  @override
  void initState() {
    BlocProvider.of<ProductDetailBloc>(context).add(ProductInitializeEvent(
        widget.parentWidget.productModel.id ?? '',
        widget.parentWidget.productModel.category ?? ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<ProductDetailBloc, ProductState>(
          builder: (BuildContext context, ProductState state) {
            return CustomScrollView(
              slivers: <Widget>[
                if (state is ProductLoadingState) ...[
                  const SliverToBoxAdapter(
                    child: CustomLoadingWidget(
                      height: 0.8,
                    ),
                  ),
                ],
                if (state is ProductSuccessState) ...[
                  state.category.fold(
                    (l) => SliverToBoxAdapter(child: Text(l)),
                    (category) => GetHeader(
                      categoryModel: category,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        widget.parentWidget.productModel.name.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'SB',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  state.listGallery.fold(
                    (l) => SliverToBoxAdapter(child: Text(l)),
                    (listGallert) => GalleryWidget(
                      listImage: listGallert,
                      defaultImageUrl:
                          widget.parentWidget.productModel.thumbnail ?? '',
                    ),
                  ),
                  state.productVariants.fold(
                    (l) => SliverToBoxAdapter(
                      child: Text(l),
                    ),
                    (productVariantList) {
                      return VariantContainerGenerator(
                        productVariantList: productVariantList,
                      );
                    },
                  ),
                  state.properties.fold(
                    (l) => SliverToBoxAdapter(
                      child: Text(l),
                    ),
                    (listProperties) => GetProperties(
                      listProperties: listProperties,
                    ),
                  ),
                  ProductDescription(
                    productDescription:
                        widget.parentWidget.productModel.description,
                  ),
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: true,
                          useSafeArea: true,
                          showDragHandle: true,
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (BuildContext context) {
                            return BlocProvider<CommentBloc>(
                              create: (context) {
                                return CommentBloc()
                                  ..add(
                                    CommentInitEvent(
                                        widget.parentWidget.productModel.id!),
                                  );
                              },
                              child: CommentBottomSheet(
                                scrollController: ScrollController(),
                                productId:
                                    widget.parentWidget.productModel.id ?? '',
                              ),
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 44,
                          right: 44,
                          bottom: 30,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: CustomColor.gray,
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                  'assets/images/icon_left_categroy.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'مشاهده',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12,
                                  color: CustomColor.blue,
                                ),
                              ),
                              const Spacer(),
                              Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  Positioned(
                                    right: 15,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 30,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 45,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Colors.pink,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 60,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '+10',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'SB',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                ':نظرات کاربران',
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 26, right: 26, top: 2, bottom: 32),
                      child: Row(
                        children: <Widget>[
                          PriceTagButton(
                            productModel: widget.parentWidget.productModel,
                          ),
                          const SizedBox(width: 20),
                          AddToBasketButton(
                            product: widget.parentWidget.productModel,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({
    super.key,
    required this.scrollController,
    required this.productId,
  });

  final String productId;

  final ScrollController scrollController;

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  TextEditingController textEditingController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (BuildContext context, CommentState state) {
        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                controller: widget.scrollController,
                slivers: [
                  if (state is CommentLoadingState) ...[
                    const SliverToBoxAdapter(
                      child: Center(
                        child: CustomLoadingWidget(
                          height: 0.1,
                        ),
                      ),
                    ),
                  ],
                  if (state is CommentSuccessState) ...[
                    state.listComments.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      },
                      (listComments) => SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: listComments.length,
                          (context, index) {
                            if (listComments[index].text != null &&
                                listComments[index].text!.isNotEmpty) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listComments[index].create,
                                      style: const TextStyle(
                                        color: CustomColor.gray,
                                        fontFamily: 'SB',
                                        fontSize: 14,
                                      ),
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          listComments[index]
                                              .userName
                                              .toString(),
                                          style: const TextStyle(
                                            fontFamily: 'SB',
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            listComments[index].text!,
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                              fontFamily: 'SM',
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    if (listComments[index].avatar != null &&
                                        listComments[index]
                                            .avatar!
                                            .isNotEmpty) ...{
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CachedImage(
                                          url: listComments[index]
                                                  .userThumbnailUrl ??
                                              '',
                                          radius: 100,
                                        ),
                                      ),
                                    } else ...{
                                      const SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircleAvatar(
                                          backgroundColor: CustomColor.blue,
                                          child: Center(
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    },
                                  ],
                                ),
                              );
                            }

                            return const SizedBox();
                          },
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (state is CommentSuccessState) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: textEditingController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'این فیلد ضروری می باشد';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                              fontFamily: 'SM',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 3),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: CustomColor.red, width: 3),
                            ),
                            errorStyle: const TextStyle(fontFamily: 'SB'),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: CustomColor.red, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: CustomColor.blue,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<CommentBloc>().add(
                                    CommentPostEvent(textEditingController.text,
                                        widget.productId),
                                  );

                              textEditingController.clear();
                            }
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: <Widget>[
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: CustomColor.blue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: const SizedBox(
                                    height: 53,
                                    child: Center(
                                      child: Text(
                                        'افزودن نظر به محصول',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'SB',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class GetProperties extends StatefulWidget {
  const GetProperties({
    super.key,
    required this.listProperties,
  });

  final List<ProdutPropertiesModel>? listProperties;

  @override
  State<GetProperties> createState() => _GetPropertiesState();
}

class _GetPropertiesState extends State<GetProperties> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 44,
                right: 44,
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: CustomColor.gray,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    isVisible
                        ? RotatedBox(
                            quarterTurns: 3,
                            child: Image.asset(
                                'assets/images/icon_left_categroy.png'),
                          )
                        : Image.asset('assets/images/icon_left_categroy.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12,
                        color: CustomColor.blue,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      ':مشخصات فنی',
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Visibility(
              visible: isVisible,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 44,
                  right: 44,
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: CustomColor.gray,
                    ),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.listProperties?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Text(
                                '${widget.listProperties?[index].title ?? ''} : ',
                                style: const TextStyle(fontFamily: 'SM'),
                              ),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  widget.listProperties?[index].value ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontFamily: 'SM'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    super.key,
    required this.productDescription,
  });

  final String? productDescription;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 44,
                right: 44,
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: CustomColor.gray,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    isVisible
                        ? RotatedBox(
                            quarterTurns: 3,
                            child: Image.asset(
                                'assets/images/icon_left_categroy.png'),
                          )
                        : Image.asset('assets/images/icon_left_categroy.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12,
                        color: CustomColor.blue,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      ':توضیحات محصول',
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: isVisible,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 44,
                right: 44,
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: CustomColor.gray,
                  ),
                ),
                child: Text(
                  widget.productDescription ?? 'توضیحی ثبت نشده است ',
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontFamily: 'SM',
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GetHeader extends StatelessWidget {
  const GetHeader({
    super.key,
    required this.categoryModel,
  });

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 32, left: 44, right: 44, top: 20),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/icon_apple_blue.png'),
                const Spacer(),
                Text(
                  categoryModel.title ?? 'دسته بندی',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'SM',
                    color: CustomColor.gray,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset('assets/images/icon_back.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  const VariantContainerGenerator({
    super.key,
    required this.productVariantList,
  });

  final List<PorductVariantModel> productVariantList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          for (var productVariant in productVariantList) ...{
            if (productVariant.variants!.isNotEmpty) ...{
              VariantGeneratorChild(
                porductVariantModel: productVariant,
              ),
            }
          }
        ],
      ),
    );
  }
}

class VariantGeneratorChild extends StatelessWidget {
  const VariantGeneratorChild({super.key, required this.porductVariantModel});

  final PorductVariantModel porductVariantModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 44, right: 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            porductVariantModel.variantType?.title ?? '',
            style: const TextStyle(fontFamily: 'SB', fontSize: 12),
          ),
          const SizedBox(height: 10),
          if (porductVariantModel.variantType?.type ==
              VariantTypeEnum.color) ...{
            ColorVariantList(
              variantModel: porductVariantModel.variants ?? [],
            ),
          },
          if (porductVariantModel.variantType?.type ==
              VariantTypeEnum.storage) ...{
            StorageVariantList(
              storageVariant: porductVariantModel.variants ?? [],
            ),
          },
        ],
      ),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  const GalleryWidget({
    super.key,
    required this.listImage,
    required this.defaultImageUrl,
  });

  final List<ProductImageModel> listImage;

  final String defaultImageUrl;

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44),
        child: Container(
          height: 284,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/icon_star.png'),
                        const SizedBox(width: 6),
                        const Text(
                          '4.6',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SM',
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 148,
                      child: CachedImage(
                        url: widget.listImage.isEmpty
                            ? widget.defaultImageUrl
                            : widget.listImage[selectedItem].imageUrl!,
                        radius: 10,
                      ),
                    ),
                    const Spacer(),
                    Image.asset('assets/images/icon_favorite_deactive.png'),
                  ],
                ),
              ),
              if (widget.listImage.isNotEmpty) const Spacer(),
              if (widget.listImage.isNotEmpty)
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 300,
                      height: 71,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 44),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.listImage.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedItem = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: CustomColor.gray,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: CachedImage(
                                      url: widget.listImage[index].imageUrl ??
                                          '',
                                      radius: 10,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  const AddToBasketButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ProductDetailBloc>().add(ProductAddToBasketEvent(product));
        context.read<BasketBloc>().add(BasketFetchFromHiveEvent());

        var snackBar = const SnackBar(
          content: Text(
            'محصول به سبد خرید اضافه شد',
            textAlign: TextAlign.right,
            style: TextStyle(fontFamily: 'SB', fontSize: 16),
          ),
          backgroundColor: CustomColor.green,
          duration: Duration(seconds: 1),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Container(
            width: 140,
            height: 60,
            decoration: BoxDecoration(
              color: CustomColor.blue,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: const SizedBox(
                width: 160,
                height: 53,
                child: Center(
                  child: Text(
                    'افزودن به سبد خرید',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'SB',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PriceTagButton extends StatelessWidget {
  const PriceTagButton({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Container(
          width: 140,
          height: 60,
          decoration: BoxDecoration(
            color: CustomColor.green,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SizedBox(
              width: 160,
              height: 54,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 7, bottom: 7),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const Text(
                      'تومان',
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          productModel.price.separateFarsiPrice,
                          style: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            color: CustomColor.backgroundScreenColor,
                          ),
                        ),
                        Text(
                          productModel.finalPrice.separateFarsiPrice,
                          style: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 30,
                      height: 25,
                      decoration: BoxDecoration(
                        color: CustomColor.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '%${productModel.prsent!.round()}',
                          style: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ColorVariantList extends StatefulWidget {
  const ColorVariantList({
    super.key,
    required this.variantModel,
  });

  final List<VariantModel> variantModel;

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.variantModel.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.only(left: 10),
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: index == selectedIndex
                      ? Border.all(
                          color: CustomColor.blue,
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        )
                      : Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(widget.variantModel[index].value.convertToHex),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: selectedIndex == index
                        ? Text(
                            widget.variantModel[index].name ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'SM',
                              fontSize: 11,
                            ),
                          )
                        : const Text(''),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StorageVariantList extends StatefulWidget {
  const StorageVariantList({
    super.key,
    required this.storageVariant,
  });

  final List<VariantModel> storageVariant;

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  // List<Widget> storageContainer = [];
  // @override
  // void initState() {
  //   for (var storageVariant in widget.storageVariant) {
  //     var item = storageContainer.add(item);
  //   }

  //   super.initState();
  // }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.storageVariant.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                width: 74,
                height: 26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: index == selectedIndex
                      ? Border.all(
                          color: CustomColor.blue,
                          width: 2,
                        )
                      : Border.all(
                          color: CustomColor.gray,
                          width: 0.5,
                        ),
                ),
                child: Center(
                  child: Text(
                    widget.storageVariant[index].value ?? '',
                    style: const TextStyle(fontFamily: 'SB', fontSize: 12),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
