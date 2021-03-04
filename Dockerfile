FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
# copy everything else and build app
COPY . ./
RUN dotnet restore
RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
COPY --from=build /app ./
EXPOSE 80
ENTRYPOINT ["dotnet", "WebAppDocker.dll"]