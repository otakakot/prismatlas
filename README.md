# prismatlas

[prisma](https://www.prisma.io/)

[atlas](https://atlasgo.io/)

## prepare

### bun and prisma

For development tool.

```shell
curl -fsSL https://bun.sh/install | bash
```
ref: https://bun.sh/

```shell
cd schema
bun install prisma
```

```shell
bun run prisma init
```

### atlas

For production tool.

```shell
curl -sSf https://atlasgo.sh | sh
```

```shell
atlas version
```

### tbls

For document tool.

```shell
go install github.com/k1LoW/tbls@latest
```

# useage

1. Edit schema.prisma 
1. Push schema.prisma
1. Execute Migrate SQL
1. Inspect schema.hcl
1. Edit schema.hcl
1. Apply schema.hcl
1. Pull schema.prisma
