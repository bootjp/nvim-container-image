# nvim-container-image

## what is this

これは bootjp が開発に用いる nvim のコンテナイメージです。
`Dockerfile` の `ENV` と git submodule の参照先を自身の dotfiles にすることでオリジナルのイメージが作成できます。

## how to use

### using this container image

```bash
docker run -it --rm -v ${PWD}:/home/bootjp/src/any_project \
  -v ~/.ssh/:/home/bootjp/.ssh/ \
  bootjp/nvim-container-image:latest bash
```

### build and publish

```bash
docker build -t bootjp/nvim-container-image:latest .
docker push bootjp/nvim-container-image:latest
```
