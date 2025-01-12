library(tidygraph)
library(ggraph)

df_party_all_connections <- df |> 
  select(id.statement, party, answer.message) |> 
  mutate(party = ifelse(party == "CDU / CSU", "CDU/CSU", party)) |> 
  # Neutrale Positionen entfernen (TODO: tbd)
  # filter(answer.message != "Neutral") |> 
  mutate(statement_answer = paste(id.statement, answer.message, sep = "#")) |> 
  pairwise_count(party, statement_answer, diag = FALSE, upper = FALSE) 

graph <- as_tbl_graph(
  df_party_all_connections,
  directed = FALSE) |> 
  activate(nodes) |> 
  mutate(degree = centrality_degree()) |> 
  activate(edges) |> 
  mutate(centrality = centrality_edge_betweenness()) |> 
  arrange(centrality)

ggraph(graph, layout = "stress", circular = TRUE) + 
  geom_edge_link(
    aes(edge_alpha = n, edge_width = n)
  ) + 
  geom_node_point(size = 4, color = "red") +
  geom_node_label(aes(label = name)) +
  scale_edge_width(range = c(0.05, 0.5))
