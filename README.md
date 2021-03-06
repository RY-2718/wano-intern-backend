# Wano intern backend
## API 仕様
`http://[hostname]/api/v1/[path]` って感じで叩いてください．
- e.g., `http://localhost:3000/api/v1/auth`
    - このURLにPOSTすると新規登録できます

### 用語
- パラメータ：POSTなどでbody部分に格納するkeyとvalue
- ヘッダ：HTTP headerに格納するkeyとvalue

### API一覧
| path | method | 説明 | 備考 |
| :-- | :-- | :-- | :-- |
| /auth | POST | 新規登録．必須パラメータ: `email`，`password`，`password_confirmation` オプションパラメータ: `image` | |
| /auth | DELETE | ユーザの削除．必須ヘッダ: `uid`，`access_token`，`client` | |
| /auth | PUT | ユーザ情報の更新．必須ヘッダ: `uid`，`access_token`，`client` オプションパラメータ：`password`，`password_confirmation`，`image` | |
| /auth/sign\_in | POST | サインイン．必須パラメータ: `email`，`password` | |
| /auth/sign\_out | DELETE | サインアウト．必須ヘッダ: `uid`，`access_token`，`client` | |
| /auth/password | POST | パスワード変更のためのリンクをメールで送信．必須ヘッダ: `uid`，`access_token`，`client` | してくれるそうなんですがどうやってメール送ってるんだ……といった感じなので使えないかもです |
| /groups | GET | ユーザが所属しているグループ一覧を取得．必須ヘッダ: `uid`，`access_token`，`client` | |
| /groups | POST | グループを新規作成．必須ヘッダ: `uid`，`access_token`，`client` 必須パラメータ: `name` オプションパラメータ: `comment` | ユーザは作成したグループに自動的に含まれます |
| /groups/:id | GET | `id`で指定されるグループの情報を取得．必須ヘッダ: `uid`，`access_token`，`client` | 正直 `GET /groups` の下位互換です．グループに所属しているユーザでないと取得できないようになっています |
| /groups/:id | PUT | `id`で指定されるグループの情報を編集．必須ヘッダ: `uid`，`access_token`，`client` オプションパラメータ: `name`，`comment` | そのグループに所属しているユーザでないと編集できないようになっています |
| /groups/:id | DELETE | `id`で指定されるグループを削除．必須ヘッダ: `uid`，`access_token`，`client` | そのグループに所属しているユーザでないと削除できないようになっています |
| /groups/:id/cards | GET | `id`で指定されるグループに含まれるカードの一覧を取得．必須ヘッダ: `uid`，`access_token`，`client` | そのグループに所属しているユーザでないと取得できないようになっています |
| /groups/:id/users | GET | `id`で指定されるグループに含まれるユーザの一覧を取得．必須ヘッダ: `uid`，`access_token`，`client` | そのグループに所属しているユーザでないと取得できないようになっています |
| /groups/:id/users | POST | `id`で指定されるグループに参加．必須ヘッダ: `uid`，`access_token`，`client` | 現状idを取得する手段がない（と思う）ので使い道がなさそうな気がする |
| /groups/:id/users | DELETE | `id`で指定されるグループから抜ける．必須ヘッダ: `uid`，`access_token`，`client` | |
| /groups/:id/users | PUT | `id`で指定されるグループに`user_id`で指定されるユーザを追加．必須ヘッダ: `uid`，`access_token`，`client` 必須パラメータ: `user_id` | `user_id` をどう取得するかみたいな問題がある |
| /cards | GET | ユーザの全てのカード取得．必須ヘッダ: `uid`，`access_token`，`client` | |
| /cards/id | GET | id のカードを取得．必須ヘッダ: `uid`，`access_token`，`client` | |
| /cards | POST | カードの投稿．必須ヘッダ: `uid`，`access_token`，`client`. 必須パラメータ `x` `y` `width` `height` `isFront` オプションパラメータ: `commentFront` `commentBack` `color` | |
| /cards/id | PUT | id のカードを更新．必須ヘッダ: `uid`，`access_token`，`client`. 必須パラメータ: `x` `y` `width` `height` `isFront`, `group\_id` オプションパラメータ: `commentFront`, `commentBack`, `color`| |
| /cards | DELETE | id のカードを消去．必須ヘッダ: `uid`，`access_token`，`client`  | |
