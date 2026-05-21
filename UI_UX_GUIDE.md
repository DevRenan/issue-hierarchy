# 🎯 Guia de Uso - Novo UI/UX

## 📱 Layout Overview

```
┌─────────────────────────────────────────────────────────────────┐
│  🔷 IssueTrack  | Search issues or nodes  | [New Issue] | 👤 You│  ← Top Nav (Fixed)
├──────────────────┬────────────────────────────────────────────────┤
│                  │                                                │
│  📁 Workspaces   │  Main Content (Turbo Frame "content")         │
│  • Workspace 1   │                                                │
│  • Workspace 2   │  ┌──────────────────────────────────┐          │
│  • Workspace 3   │  │ Issue Title                      │  ← Cards│
│                  │  │ Status: Open | Priority: High   │         │
│  📊 Structure    │  └──────────────────────────────────┘          │
│  ├─ Node A       │  ┌──────────────────────────────────┐          │
│  │  ├─ Node A1   │  │ Another Issue                    │          │
│  │  └─ Node A2   │  │ Status: In Progress | Pri: Med   │          │
│  ├─ Node B       │  └──────────────────────────────────┘          │
│  └─ Node C       │                                                │
│                  │  [Edit] [Back]                                 │
└──────────────────┴────────────────────────────────────────────────┘
```

---

## 🧭 Navegação e Workflows

### Workflow 1: Explorar Workspaces

1. **Página Inicial**: `/workspaces`
   - Grid de workspace cards
   - Cada card mostra: nome, descrição truncada, contagem de nodes
   - Botões: Open, Edit, Delete

2. **Abrir Workspace**: Clique em "Open"
   - Carrega `/workspaces/:id` no main content
   - Sidebar mostra "Structure" com árvore de nodes
   - Main area mostra instrções de "Getting Started"

---

### Workflow 2: Criar Node e Issues

1. **Na página do Workspace**, clique em "New node"
   - Abre formulário de node
   - Preenchher: name, description, node_type, parent (optional)

2. **Node criado com sucesso**
   - Redirect para `/nodes/:id` (no main content via Turbo)
   - Sidebar atualiza com novo node na árvore

3. **Na view do Node**, clique em "New Issue"
   - Abre formulário de issue pré-preenchido com workspace_id e node_id
   - Preenchher: title, description, status, priority

4. **Issue criada com sucesso**
   - Redirect para `/nodes/:id`
   - Nova issue aparece na seção "Issues" do node

---

### Workflow 3: Navegar Node Tree

1. **No Sidebar**, veja a árvore de nodes
   - Ícone chevron (🔽) indica que node tem filhos
   - Clique no chevron para colapsar/expandir (client-side, sem reload)
   - Clique no nome do node para abrir seu detalhe

2. **Node Detail View** (`/nodes/:id`)
   - Header com: nome, tipo (badge), descrição
   - Left column: Child Nodes (se houver)
   - Right column: Issues do node (cards)
   - Botões: Edit, New Issue, Back, Destroy

---

### Workflow 4: Gerenciar Issues

1. **Issue List** (`/issues` ou card grid em node/workspace)
   - Cards com: título, descrição truncada, node relacionado
   - Status e Priority badges (color-coded)
   - Metadata: updated_at, comments count, files count
   - Clique no card ou título para abrir detalhe

2. **Issue Detail** (`/issues/:id`)
   - Header: título, node, status badge, priority badge
   - Descrição (formato completo)
   - **Comments Section**: Timeline de comentários
     - Avatar, nome, timestamp para cada comentário
     - Form para adicionar novo comentário
   - **Attachments Sidebar**: Lista de files com download links
   - Botões: Edit, Back, Destroy

3. **Adicionar Comentário**
   - Textarea: "Add a comment..."
   - Clique "Comment" para submeter
   - Comentário aparece na timeline

---

## 🎨 Visual Indicators (Color Coding)

### Status Badges
```
🟢 Open        → bg-green-100, text-green-800
🟡 In Progress → bg-yellow-100, text-yellow-800
🔵 Resolved    → bg-blue-100, text-blue-800
⚫ Closed      → bg-gray-100, text-gray-700
```

### Priority Badges
```
🟢 Low      → bg-green-50, text-green-700
🟡 Medium   → bg-yellow-50, text-yellow-700
🟠 High     → bg-orange-50, text-orange-700
🔴 Critical → bg-red-50, text-red-700
```

### Node Type Badge
```
Qualquer node_type → bg-gray-100, text-gray-600
Exemplo: "Project", "Phase", "Feature", "Bug", etc.
```

---

## 💡 Tips & Tricks

### Sidebar Collapse (Client-side)
- Clique no chevron 🔽 para colapsar node
- Chevron rotaciona 90° para indicar collapsed state
- Sem servidor roundtrip (Stimulus controller)
- Estado **não persiste** na recarga de página (próxima melhoria)

### Turbo Frames Navigation
- Links com `data-turbo-frame="content"` não fazem reload
- Observe que URL continua a mesma (dentro do frame)
- Clique em "Back" para voltar

### Search Form
- Top nav tem input de busca
- Form faz GET para `/issues?q=termo`
- Ainda não implementado filtro completo (próxima versão)

### Responsive Design
- Em **mobile** (< 768px): Sidebar escondida (hidden)
- Top nav permanece sempre visível
- Grid de cards adapta para 1 coluna
- Teste com DevTools mobile mode

---

## 📋 Controller Actions & Routes

### Workspaces
```
GET  /workspaces              → index (grid de workspaces)
GET  /workspaces/new          → new (form)
POST /workspaces              → create (save)
GET  /workspaces/:id          → show (detail)
GET  /workspaces/:id/edit     → edit (form)
PUT  /workspaces/:id          → update (save)
DELETE /workspaces/:id        → destroy
```

### Nodes
```
GET  /nodes                   → index (estrutura do workspace)
GET  /nodes/new               → new (form)
POST /nodes                   → create (save)
GET  /nodes/:id               → show (detalhe com child nodes e issues)
GET  /nodes/:id/edit          → edit (form)
PUT  /nodes/:id               → update (save)
DELETE /nodes/:id             → destroy
```

### Issues
```
GET  /issues                  → index (grid de todas as issues)
GET  /issues/new              → new (form)
POST /issues                  → create (save)
GET  /issues/:id              → show (detalhe com comentários)
GET  /issues/:id/edit         → edit (form)
PUT  /issues/:id              → update (save)
DELETE /issues/:id            → destroy
```

### Comments
```
POST /issues/:issue_id/comments       → create (add comment)
PATCH /comments/:id                   → update
DELETE /comments/:id                  → destroy
```

### Attachments
```
GET /attachments/:id          → download
DELETE /attachments/:id       → destroy
```

---

## 🔌 Turbo Frames Targets

```erb
<!-- Top level frame in layout -->
<%= turbo_frame_tag "content" %>

<!-- Node tree frame in sidebar -->
<%= turbo_frame_tag "node_tree" %>

<!-- Issues list frame in workspace show -->
<%= turbo_frame_tag "issues" %>
```

**Usage**: 
```erb
<%= link_to "Open", workspace_path(ws), data: { turbo_frame: "content" } %>
```
- Link carrega conteúdo apenas dentro daquele frame
- Não faz reload de toda a página
- Sidebar e top nav permanecem iguais

---

## 🧠 Data Relationships

```
Workspace (1:M) → Nodes (1:M) → Issues (1:M) → Comments
                                            ↘ Attachments
```

### Correct Usage
- ✅ `@workspace.nodes` - todos os nodes do workspace
- ✅ `@node.children` - child nodes
- ✅ `@node.issues` - issues do node
- ✅ `@issue.comments` - comentários da issue
- ❌ `@workspace.issues` - ❌ não existe (Use `@node.issues` ao invés)

---

## 🚨 Common Issues & Fixes

### "Undefined method 'issues' for Workspace"
- **Causa**: Tentou usar `@workspace.issues`
- **Fix**: Use `@node.issues` ao invés
- **Arquivo**: `app/views/workspaces/show.html.erb` ← Corrigido ✅

### Tailwind CSS não aparece
- **Causa**: Assets não compilados
- **Fix**: 
  ```bash
  bin/rails tailwindcss:build
  bin/rails assets:precompile
  bin/rails tmp:clear
  bin/rails server
  ```

### Sidebar não mostra workspaces
- **Causa**: `@workspaces` não carregada
- **Fix**: Verificar `app/controllers/application_controller.rb`
  ```ruby
  before_action :load_workspaces
  ```

### Nodes não colapsam
- **Causa**: Stimulus controller não carregado
- **Fix**: 
  ```bash
  # Verificar console (F12)
  # Deve ver registrado: Stimulus controller "tree"
  # Se não, reiniciar servidor
  ```

### Links não navegam sem reload
- **Causa**: `data-turbo-frame` ausente ou incorreto
- **Fix**: Certificar que link tem `data-turbo-frame="content"` ou alvo correto

---

## 📚 File Structure Reference

```
app/
├── views/
│   ├── layouts/application.html.erb      ← Main layout com sidebar/topnav
│   ├── shared/
│   │   ├── _top_nav.html.erb             ← Logo, Search, New Issue button
│   │   └── _sidebar.html.erb             ← Workspaces + Node tree
│   ├── nodes/
│   │   ├── _tree.html.erb                ← Recursivo node tree
│   │   ├── _node_item.html.erb           ← Single node row
│   │   ├── show.html.erb                 ← Node detail
│   │   └── index.html.erb                ← Node structure
│   ├── issues/
│   │   ├── _issue_card.html.erb          ← Card visual
│   │   ├── _list.html.erb                ← Grid de cards
│   │   └── show.html.erb                 ← Issue detail
│   ├── comments/
│   │   ├── _comment.html.erb             ← Timeline item
│   │   └── _form.html.erb                ← Add comment form
│   └── attachments/
│       └── _attachment.html.erb          ← File item
├── helpers/
│   ├── nodes_helper.rb                   ← node_depth_padding
│   └── issues_helper.rb                  ← status_badge, priority_badge
├── controllers/
│   ├── application_controller.rb         ← load_workspaces
│   ├── nodes_controller.rb               ← set_workspace
│   └── issues_controller.rb              ← set_workspace
└── javascript/controllers/
    └── tree_controller.js                ← Collapse/Expand logic
```

---

## 🎓 Next Learning Steps

1. **Customize Colors**: Edite `app/helpers/issues_helper.rb` para mudar cores dos badges
2. **Add Icons**: Adicione icons SVG em nodes e issues
3. **Implement Search**: Melhore o form de busca em `_top_nav.html.erb`
4. **Add Filters**: Crie filtros por status/priority
5. **Persist State**: Use localStorage para salvar expand/collapse state
6. **Add User Context**: Mostrar quem criou/atualizou cada item

---

**Divirta-se construindo! 🚀**

