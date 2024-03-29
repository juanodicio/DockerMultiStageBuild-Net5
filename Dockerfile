FROM mcr.microsoft.com/dotnet/sdk:5.0 AS mybuild
# build app
COPY . ./
RUN dotnet restore
RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
COPY --from=mybuild /app ./
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80
ENTRYPOINT ["dotnet", "WebAppDocker.dll"]