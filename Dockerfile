FROM golang:1.16-alpine AS build

# Crie um diretório de trabalho
WORKDIR /app

# Copie os arquivos necessários para compilar o aplicativo
COPY main.go .

# Compile o aplicativo
RUN CGO_ENABLED=0 GOOS=linux go build -o app main.go

# Use uma imagem mínima do Alpine para criar uma imagem final menor
FROM hello-world:latest

WORKDIR /app

# Copie o arquivo binário do aplicativo do estágio de compilação para a nova imagem

COPY --from=build /app/app /app

# Execute o aplicativo
CMD ["./app"]