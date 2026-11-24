# Defesa de Arquitetura de Software — Pull Request

## Nome do Avaliador: Derick Fernando Lins Rodrigues.
- **Nome do Estudante:** [Leonardo Figura]
- **Artefato(s) de Responsabilidade:** [ D2 ]
- 
Análise do arquivo D2.txt: C4 Nível 2 (Contêineres) do Assistente de IA para Exportação (Sistema Fiep)

O que este PR introduz na Documentação Viva?
O PR adiciona à pasta /docs/ um único artefato, o diagrama C4 Nível 2 (Contêineres) do Assistente de IA para Exportação, escrito em D2 (Diagrams-as-Code). Ele detalha o interior do sistema com 6 contêineres de aplicação, 4 bancos de dados e 2 sistemas externos, e mostra como os dois atores (usuário e curador) interagem com ele.

[ ] Visão Funcional / Estrutural: não incluída. Não há Casos de Uso nem Diagrama de Classes, embora os requisitos funcionais (RF01 a RF21) apareçam como rastreabilidade nos rótulos.
[ ] Visão Comportamental: não incluída. Não há Sequência, Atividades ou Máquina de Estados, apesar de os rótulos de métodos (enviarPergunta, registrarConsulta) já sugerirem um diagrama de sequência.
[ ] Visão Arquitetural Macro: incluída. É o Modelo C4 L2 em D2, com Pessoas, Usuário de exportação e Curador regulatório.
Contêineres de aplicação: Interface, Backend/Orquestrador RAG, Gerador de Saídas Estruturadas, Serviço de Embeddings, LLM e Atualização Normativa.
Bancos de dados: Banco Vetorial, Repositório de Regras Aduaneiras, Histórico e Perfil da Empresa e Registro de Auditoria.
Sistemas externos: Fontes normativas oficiais e Siscomex (marcado como futuro fora do escopo inicial -> RF21).
[ ] Governança: não incluída. Não há ADR, embora as decisões abaixo mereçam um.


Defesa das Decisões de Design (Justificativa Técnica)

1. Escolha de Abstrações e Desacoplamento
Orquestrador central (padrão RAG): o orquestrador é o único ponto que coordena embeddings, busca vetorial, regras, LLM, histórico e saídas. Isso mantém os demais contêineres sem conhecimento uns dos outros e deixa o fluxo de negócio em um só lugar.
Separação entre conhecimento semântico e estruturado: o Banco Vetorial (busca por similaridade de trechos) é separado do Repositório de Regras (regras, requisitos, vigência e fontes). A resposta combina recuperação semântica com regras verificáveis, o que reduz o risco de alucinação em um domínio regulatório.
Serviço de Embeddings e LLM como contêineres próprios: são substituíveis (troca de provedor ou modelo) sem alterar o orquestrador. O embeddings é reutilizado na consulta e na atualização normativa, garantindo vetores consistentes entre indexação e busca.
Separação entre leitura e escrita da base normativa: o contêiner atualizacao é o único que grava no Repositório e no Banco Vetorial. O orquestrador e o gerador de saídas apenas leem, o que protege a integridade das regras. O curador humano aprova as mudanças (human-in-the-loop).
Gerador de Saídas Estruturadas: isola a formatação (checklist, roteiro, comparação, relatório) da lógica de interpretação e lê direto do Repositório, mantendo fontes e requisitos rastreáveis.
Auditoria separada: registrar pergunta, fontes e resposta em um banco próprio atende rastreabilidade e conformidade sem poluir o histórico do usuário.
Relacionamentos em estilo de contrato (buscarSimilares, recuperarRegras, gerarResposta) já indicam as operações que as interfaces do nível L3 deverão expor.
Classes D2 (pessoa, conteiner, banco, externo, futuro): padronizam a notação C4, com cilindros para bancos, tracejado para o futuro e cinza para externos.

2. Dinâmica e Resiliência
Como o diagrama é estático, não há alt/else nem guardas de estado. A resiliência aparece apenas de forma estrutural:
Mensagem assíncrona: orquestrador -> auditoria está tracejada e marcada como "(assíncrono)". Uma falha ou lentidão na auditoria não bloqueia a resposta ao usuário.
Integração futura isolada: o Siscomex (RF21) está tracejado e em cinza claro, então sua ausência ou indisponibilidade não afeta o escopo inicial.
Atualização desacoplada do fluxo de consulta: reindexar normas não interrompe o atendimento, e a vigência fica registrada no Repositório.
Pontos não cobertos (devem ir para diagramas de sequência ou ADRs): falha do LLM ou do serviço de embeddings, ausência de trechos relevantes na busca, regra vencida ou sem vigência e consistência entre o Banco Vetorial e o Repositório durante a reindexação.

4. Trade-offs
- Orquestrador centralizado
Prós: fluxo claro e fácil de auditar.
Contras: risco de gargalo e de virar um "God component"; ponto único de falha.
- Dois armazenamentos (vetorial + regras)
Prós: precisão e rastreabilidade das regras, somadas à busca semântica.
Contras: complexidade para manter a consistência entre ambos.
- Embeddings e LLM como contêineres separados
Prós: substituíveis e escaláveis de forma independente.
Contras: mais latência, custo e pontos de falha.
- Auditoria assíncrona
Prós: não penaliza a latência da resposta.
Contras: possível perda de registros se não houver fila ou retentativa.
- Curador humano na atualização
Prós: confiabilidade jurídica da base.
Contras: atualização mais lenta e dependente de pessoas.
- Siscomex adiado (RF21)
Prós: escopo inicial menor e entrega mais rápida.
Contras: dados menos atualizados e dependentes de curadoria manual.
- Bancos separados (histórico, auditoria, regras)
Prós: responsabilidades claras e controle de acesso por tipo de dado.
Contras: mais infraestrutura para operar.
- Consistência Cross-Diagramas (Checklist de Autoverificação)

Métodos do Diagrama de Sequência existem nas interfaces do Diagrama de Classes. Não verificável: esses diagramas não fazem parte do PR. Recomenda-se usar enviarPergunta, entregarResposta, gerarEmbedding, buscarSimilares, recuperarRegras, gerarResposta e registrarConsulta exatamente com esses nomes nos futuros diagramas.
Contêineres e componentes correspondem à nomenclatura do C4 L2/L3. Os rótulos seguem o padrão Nome [Tipo] Descrição, e a rastreabilidade com os RFs é consistente.  *Ressalvas:*
Os identificadores internos (orquestrador, saidas) diferem dos rótulos exibidos ("Backend / Orquestrador RAG" e "Gerador de Saídas Estruturadas"). Convém fixar uma nomenclatura única para os L3 e as sequências.
O usuário acessa a Interface por "[Navegador]". Se houver front-end e API separados, isso deve ser explicitado.
O limite do sistema é rotulado como "Assistente de IA para Exportação (Sistema Fiep)". Vale padronizar com o C4 L1.
Transições de estado refletem os gatilhos das atividades. Não aplicável: não há Máquina de Estados no PR. Candidatos futuros: ciclo de vida de uma regra (rascunho → aprovada → vigente → revogada) e de uma consulta.
Validação da Sintaxe Diagrams-as-Code / Models-as-Code
Ferramenta de Compilação/Renderização Utilizada: [ D2 ]
Status da Compilação: Código limpo e sem erros de sintaxe ao renderizar.
