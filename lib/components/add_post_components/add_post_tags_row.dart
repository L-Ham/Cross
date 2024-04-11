import 'package:flutter/material.dart';

import 'add_post_brand_affiliate_tag.dart';
import 'add_post_spoiler_tag.dart';

class AddPostTagsRow extends StatelessWidget {
  const AddPostTagsRow({
    super.key,
    required this.isSpoiler,
    required this.isBrandAffiliate,
  });

  final bool isSpoiler;
  final bool isBrandAffiliate;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Visibility(
          visible: isSpoiler,
          child: const AddPostSpoilerTag(),
        ),
        Visibility(
          visible: isBrandAffiliate,
          child: const AddPostBrandAffiliateTag(),
        )
      ],
    );
  }
}
