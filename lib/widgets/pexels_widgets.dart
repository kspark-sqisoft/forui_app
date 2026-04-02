import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../application/pexels_service.dart';

/// Pexels 키가 없거나 오류일 때 카드 헤더용 그라데이션 자리표시자.
Widget pexelsGradientPlaceholder(BuildContext context, {required double height}) {
  final c = context.theme.colors;
  return Container(
    height: height,
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          c.primary.withValues(alpha: 0.35),
          c.muted,
        ],
      ),
    ),
  );
}

/// [FCard.image]용 — Pexels 검색으로 랜덤 사진 한 장. 키 없으면 [pexelsGradientPlaceholder].
class PexelsCardHeaderImage extends ConsumerStatefulWidget {
  const PexelsCardHeaderImage({super.key, this.height = 140});

  final double height;

  @override
  ConsumerState<PexelsCardHeaderImage> createState() => _PexelsCardHeaderImageState();
}

class _PexelsCardHeaderImageState extends ConsumerState<PexelsCardHeaderImage> {
  PexelsPhoto? _photo;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final svc = ref.read(pexelsServiceProvider);
    if (svc == null || !mounted) {
      return;
    }
    setState(() => _loading = true);
    final photo = await svc.fetchRandomPhoto();
    if (!mounted) {
      return;
    }
    setState(() {
      _photo = photo;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final svc = ref.watch(pexelsServiceProvider);
    if (svc == null) {
      return pexelsGradientPlaceholder(context, height: widget.height);
    }
    if (_loading || _photo == null) {
      return SizedBox(
        height: widget.height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            pexelsGradientPlaceholder(context, height: widget.height),
            if (_loading)
              const Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
          ],
        ),
      );
    }
    final photo = _photo!;
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            photo.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) {
                return child;
              }
              return pexelsGradientPlaceholder(context, height: widget.height);
            },
            errorBuilder: (_, __, ___) => pexelsGradientPlaceholder(context, height: widget.height),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.65),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 6),
                child: Text(
                  '${photo.photographer} / Pexels',
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// [FAvatar] + Pexels 랜덤 초상. 키 없으면 Dicebear + 안내 문구.
class PexelsRandomAvatarDemo extends ConsumerStatefulWidget {
  const PexelsRandomAvatarDemo({super.key, this.size = 48});

  final double size;

  @override
  ConsumerState<PexelsRandomAvatarDemo> createState() => _PexelsRandomAvatarDemoState();
}

class _PexelsRandomAvatarDemoState extends ConsumerState<PexelsRandomAvatarDemo> {
  PexelsPhoto? _photo;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final svc = ref.read(pexelsServiceProvider);
    if (svc == null || !mounted) {
      return;
    }
    setState(() => _loading = true);
    final photo = await svc.fetchRandomPhoto();
    if (!mounted) {
      return;
    }
    setState(() {
      _photo = photo;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final typo = context.theme.typography;
    final muted = context.theme.colors.mutedForeground;
    final svc = ref.watch(pexelsServiceProvider);
    if (svc == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FAvatar(
            size: widget.size,
            image: NetworkImage(
              'https://api.dicebear.com/7.x/avataaars/png?seed=forui',
            ),
            fallback: const Text('?'),
          ),
          const SizedBox(height: 6),
          Text(
            '프로젝트 루트 .env 의 PEXELS_API_KEY 또는 --dart-define 으로 넣으면 Pexels 랜덤 이미지로 바뀝니다.',
            style: typo.xs.copyWith(color: muted),
          ),
        ],
      );
    }
    if (_loading || _photo == null) {
      return SizedBox(
        width: widget.size,
        height: widget.size,
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }
    final photo = _photo!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FAvatar(
          size: widget.size,
          image: NetworkImage(photo.portraitUrl),
          fallback: const Text('?'),
        ),
        const SizedBox(height: 6),
        Text(
          '${photo.photographer} / Pexels',
          style: typo.xs.copyWith(color: muted),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
