FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/sdk:7.0 AS final-env
ENV ASPNETCORE_URLS http://*:4000
WORKDIR /app
COPY --from=build-env /app/out .
EXPOSE 4000
EXPOSE 80
EXPOSE 443
ENTRYPOINT [ "dotnet", "WebApi.dll" ]
