temp <- tempfile()
download.file("ftp://ftp.datasus.gov.br/cnes/CEP_BRASIL.ZIP", "CEP_BRASIL.zip", mode='wb')

file_cep <- unz("CEP_BRASIL.zip", "CEP.txt")
file_cep_alterado <- unz("CEP_BRASIL.zip", "CEPALTERADO.txt")

cep <- read.delim(file_cep, header=FALSE) 
names(cep) <- c("cep", "sigla_uf", "ibge6")

cep_alterado <- read.delim(file_cep_alterado, header=FALSE)
names(cep_alterado) <- c("cep", "sigla_uf", "ibge6", "alteracao")

saveRDS(cep, "cep.rds")
saveRDS(cep_alterado, "cep_alterado.rds")

df <- read.csv("base_nrow.csv")
df_nova <- data.frame(data = as.character(Sys.Date()), nrow_cep = nrow(cep), nrow_cep_alterado = nrow(cep_alterado))
df <- rbind(df, df_nova)
write.csv(df, "base_nrow.csv", row.names= FALSE)

