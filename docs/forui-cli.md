# Forui CLI 사용법

프로젝트에 테마·스타일·스니펫을 생성할 때 쓰는 Forui 공식 CLI 요약입니다.  
원문·최신 옵션은 **[Forui CLI 문서](https://forui.dev/docs/reference/cli)** 를 기준으로 하세요.

## 특징

- 별도 설치 없이 `dart run forui …` 로 실행합니다.
- 생성된 파일을 직접 수정해 디자인에 맞출 수 있습니다.
- CLI 자체가 앱 번들 크기를 늘리지 않습니다.

---

## `init`

프로젝트 루트에 `forui.yaml`과 `main.dart` 초안을 만듭니다.

```bash
dart run forui init
```

```
Usage: forui init
-h, --help         도움말
-f, --force        이미 있으면 덮어쓰기
-t, --template     main.dart 템플릿
                   [basic (기본값), router]
```

---

## `snippet`

### `snippet create`

스니펫 코드를 생성합니다. 기본 출력은 `lib` 입니다.

```bash
dart run forui snippet create [snippets]
```

```
Usage: forui snippet create [snippets]
-h, --help      도움말
-f, --force     덮어쓰기
-o, --output    출력 경로(프로젝트 기준). 기본값: lib
```

### `snippet ls`

사용 가능한 스니펫 목록을 봅니다.

```bash
dart run forui snippet ls
```

```
Usage: forui snippet ls
-h, --help    도움말
```

---

## `style`

### `style create`

위젯 스타일 파일을 생성합니다. 기본 출력은 `lib/theme` 입니다.  
생성 후 테마에 연결하는 방법은 [Customizing Themes](https://forui.dev/docs/guides/customizing-themes) 등 가이드를 참고하세요.

```bash
dart run forui style create [styles]
```

```
Usage: forui style create [styles]
-h, --help      도움말
-a, --all       모든 스타일 한 번에 생성
-f, --force     덮어쓰기
-o, --output    출력 디렉터리(프로젝트 기준). 기본값: lib/theme
```

### `style ls`

생성 가능한 스타일 이름 목록을 봅니다.

```bash
dart run forui style ls
```

```
Usage: forui style ls
-h, --help    도움말
```

---

## `theme`

### `theme create`

테마 파일을 생성합니다. 기본 경로는 `lib/theme/theme.dart` 입니다.

```bash
dart run forui theme create [theme]
```

```
Usage: forui theme create [theme]
-h, --help      도움말
-f, --force     덮어쓰기
-o, --output    출력 경로(프로젝트 기준). 기본값: lib/theme/theme.dart
```

### `theme ls`

생성 가능한 테마 이름 목록을 봅니다.

```bash
dart run forui theme ls
```

```
Usage: forui theme ls
-h, --help    도움말
```

---

## 이 프로젝트에서의 참고

- 갤러리 앱은 `main.dart`에서 `FTheme` + Riverpod(`resolvedForuiThemeProvider`)로 테마를 씁니다. CLI로 `init`/`theme create`를 돌리면 **기존 `main.dart`를 덮어쓸 수 있으므로** `-f` 없이 먼저 백업하거나 출력 경로(`-o`)를 지정하는 것이 안전합니다.
- 코드로만 테마를 바꾸는 예시는 `lib/pages/concepts/customizing_themes_page.dart` 를 보면 됩니다.

## 관련 링크

- [CLI Reference](https://forui.dev/docs/reference/cli)
- [Customizing Themes](https://forui.dev/docs/guides/customizing-themes)
