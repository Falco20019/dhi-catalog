REPOSITORY_NAME=registry.arculus.it/devops/container-images/mirrors

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    https://raw.githubusercontent.com/Falco20019/dhi-catalog/refs/heads/dotnet-11-rc/image/dotnet/debian-13/11.yaml \
    --sbom=generator=dhi.io/scout-sbom-indexer:1 \
    --provenance=1 \
    --tag $REPOSITORY_NAME/dotnet:11.0 \
    --push
docker buildx build \
    --platform linux/amd64,linux/arm64 \
    https://raw.githubusercontent.com/Falco20019/dhi-catalog/refs/heads/dotnet-11-rc/image/dotnet/debian-13/11-sdk.yaml \
    --sbom=generator=dhi.io/scout-sbom-indexer:1 \
    --provenance=1 \
    --tag $REPOSITORY_NAME/dotnet:11.0-sdk \
    --push
docker buildx build \
    --platform linux/amd64,linux/arm64 \
    https://raw.githubusercontent.com/Falco20019/dhi-catalog/refs/heads/dotnet-11-rc/image/aspnetcore/debian-13/11.yaml \
    --sbom=generator=dhi.io/scout-sbom-indexer:1 \
    --provenance=1 \
    --tag $REPOSITORY_NAME/aspnetcore:11.0 \
    --push
docker buildx build \
    --platform linux/amd64,linux/arm64 \
    https://raw.githubusercontent.com/Falco20019/dhi-catalog/refs/heads/dotnet-11-rc/image/aspnetcore/debian-13/11-dev.yaml \
    --sbom=generator=dhi.io/scout-sbom-indexer:1 \
    --provenance=1 \
    --tag $REPOSITORY_NAME/aspnetcore:11.0-dev \
    --push
