import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';

class NativeAdWidget extends StatefulWidget {
  final String placement;
  final double height;

  const NativeAdWidget({
    super.key,
    this.placement = 'default',
    this.height = 300,
  });

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? _nativeAd;
  bool _isAdLoaded = false;
  bool _isLoading = false;
  String? _errorMessage;
  int _retryCount = 0;
  static const int maxRetries = 2;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    _nativeAd = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.white,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          backgroundColor: Colors.blue,
          style: NativeTemplateFontStyle.monospace,
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black,
          backgroundColor: Colors.white,
          style: NativeTemplateFontStyle.bold,
          size: 16.0,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.grey,
          backgroundColor: Colors.white,
          style: NativeTemplateFontStyle.italic,
          size: 14.0,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.grey,
          backgroundColor: Colors.white,
          style: NativeTemplateFontStyle.normal,
          size: 12.0,
        ),
      ),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isAdLoaded = true;
            _isLoading = false;
          });
          debugPrint('Native ad loaded: ${widget.placement}');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('Native ad failed to load: ${widget.placement} - $error');
          ad.dispose();

          if (_retryCount < maxRetries) {
            _retryCount++;
            debugPrint('Retrying native ad load (attempt ${_retryCount + 1})');
            Future.delayed(const Duration(seconds: 1), () {
              if (mounted) _loadAd();
            });
          } else {
            setState(() {
              _isLoading = false;
              _errorMessage =
                  'Failed to load ad after ${maxRetries + 1} attempts';
            });
          }
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdLoaded && _nativeAd != null) {
      return Container(
        height: widget.height,
        alignment: Alignment.center,
        child: AdWidget(ad: _nativeAd!),
      );
    }

    if (_isLoading) {
      return Container(
        height: widget.height,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Container(
        height: widget.height,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Text(
          'Ad unavailable',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      );
    }

    return SizedBox(height: widget.height);
  }
}

// Creative native ad implementations
class CreativeNativeAds {
  // Native ad in feed
  static Widget feedNativeAd() {
    return const Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(Icons.campaign, color: Colors.blue, size: 20),
                SizedBox(width: 8),
                Text(
                  'Sponsored',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          NativeAdWidget(
            placement: 'feed',
            height: 250,
          ),
        ],
      ),
    );
  }

  // Native ad in article
  static Widget articleNativeAd() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: const Text(
              'Advertisement',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const NativeAdWidget(
            placement: 'article',
            height: 280,
          ),
        ],
      ),
    );
  }

  // Native ad in card
  static Widget cardNativeAd() {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[50]!, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(Icons.star_outline, color: Colors.amber),
                SizedBox(width: 8),
                Text(
                  'Featured',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          NativeAdWidget(
            placement: 'card',
            height: 260,
          ),
        ],
      ),
    );
  }

  // Native ad with custom styling
  static Widget customNativeAd() {
    return Container(
      height: 320,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: const NativeAdWidget(
          placement: 'custom',
          height: 320,
        ),
      ),
    );
  }
}
