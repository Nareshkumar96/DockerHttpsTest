FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build1
WORKDIR /app
RUN git clone https://github.com/Nareshkumar96/DockerHttpsTest.git
WORKDIR /app/DockerHttpsTest

RUN dotnet restore
RUN dotnet publish -c Release /p:EnvironmentName=Development -o out
	
FROM mcr.microsoft.com/dotnet/aspnet:3.1
WORKDIR /app
EXPOSE 8081
EXPOSE 80
COPY --from=build1 /app/DockerHttpsTest/out .

ENTRYPOINT ["dotnet", "DockertHttpsTest.dll"]
