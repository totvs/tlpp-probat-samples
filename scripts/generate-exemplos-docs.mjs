#!/usr/bin/env node
/**
 * Gera docs/exemplos/*.mdx a partir de test/ e src/
 */
import fs from 'node:fs';
import path from 'node:path';
import {fileURLToPath} from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const OUT = path.join(ROOT, 'docs/exemplos');

const REPO_ID = 'probat-samples';
const DOCS_BASE = '/docs/tlpp/probat/exemplos-repositorio';

const SCAN_ROOTS = ['test', 'src'];

const CATEGORY_LABELS = {
  'test/probat_resources': 'Recursos básicos',
  'test/apartness': 'Execução apartada',
  'test/api': 'Testes de API REST',
  'test/integration': 'Integração com banco',
  'test/tdd': 'TDD',
  'test/coverage': 'Cobertura de código',
  'test/config': 'Configuração',
  'test/unit/math': 'Unitários · math',
  'test/unit/prw': 'Unitários · AdvPL',
  'test/unit/utils': 'Unitários · utils',
  'src/api': 'Código-fonte · API',
  'src/coverage': 'Código-fonte · cobertura',
  'src/math': 'Código-fonte · math',
  'src/tdd': 'Código-fonte · TDD',
  'src/tlpp': 'Código-fonte · TLPP',
  'src/utils': 'Código-fonte · utils',
};

const CATEGORY_ORDER = [
  'test/probat_resources',
  'test/apartness',
  'test/api',
  'test/integration',
  'test/tdd',
  'test/coverage',
  'test/config',
  'test/unit/math',
  'test/unit/prw',
  'test/unit/utils',
  'src/api',
  'src/coverage',
  'src/math',
  'src/tdd',
  'src/tlpp',
  'src/utils',
];

function slug(category) {
  return category.replace(/\//g, '-');
}

function walkTlpp(rootDir, prefix) {
  const entries = [];
  if (!fs.existsSync(rootDir)) return entries;

  function walk(dir, base) {
    for (const ent of fs.readdirSync(dir, {withFileTypes: true})) {
      const rel = base ? `${base}/${ent.name}` : ent.name;
      const abs = path.join(dir, ent.name);
      if (ent.isDirectory()) walk(abs, rel);
      else if (ent.name.endsWith('.tlpp')) {
        entries.push({
          category: `${prefix}/${base}`.replace(/\\/g, '/'),
          file: ent.name,
        });
      }
    }
  }

  for (const ent of fs.readdirSync(rootDir, {withFileTypes: true})) {
    if (ent.isDirectory()) {
      walk(path.join(rootDir, ent.name), ent.name);
    } else if (ent.name.endsWith('.tlpp')) {
      entries.push({category: prefix, file: ent.name});
    }
  }

  return entries;
}

function pageMdx(category, files, position) {
  const label = CATEGORY_LABELS[category] ?? category;
  const rows = files
    .sort((a, b) => a.file.localeCompare(b.file))
    .map(
      (f) =>
        `| \`${f.file}\` | <ExemploRef repo="${REPO_ID}" file="${f.file}" path="${category}" /> |`,
    )
    .join('\n');

  return `---
title: "${label}"
sidebar_label: "${label}"
sidebar_position: ${position}
displayed_sidebar: restSidebar
---

import ExemploRef from '@site/src/components/ExemploRef';
import RepoLink from '@site/src/components/RepoLink';

# ${label}

Exemplos TLPP em <RepoLink id="${REPO_ID}" /> (\`${category}/\`).

| Arquivo | Repositório |
|---------|-------------|
${rows}
`;
}

function main() {
  const manifest = SCAN_ROOTS.flatMap((root) =>
    walkTlpp(path.join(ROOT, root), root),
  );

  const byCategory = new Map();
  for (const entry of manifest) {
    if (!byCategory.has(entry.category)) byCategory.set(entry.category, []);
    byCategory.get(entry.category).push(entry);
  }

  fs.rmSync(OUT, {recursive: true, force: true});
  fs.mkdirSync(OUT, {recursive: true});

  const categories = [
    ...CATEGORY_ORDER.filter((c) => byCategory.has(c)),
    ...[...byCategory.keys()].filter((c) => !CATEGORY_ORDER.includes(c)).sort(),
  ];

  let pos = 2;
  for (const cat of categories) {
    fs.writeFileSync(
      path.join(OUT, `${slug(cat)}.mdx`),
      pageMdx(cat, byCategory.get(cat), pos++),
      'utf8',
    );
  }

  const indexLinks = categories
    .map((cat) => {
      const label = CATEGORY_LABELS[cat] ?? cat;
      return `- [${label}](${DOCS_BASE}/${slug(cat)})`;
    })
    .join('\n');

  fs.writeFileSync(
    path.join(OUT, 'index.mdx'),
    `---
title: Exemplos do repositório
sidebar_label: Visão geral
sidebar_position: 1
displayed_sidebar: restSidebar
---

import RepoLink from '@site/src/components/RepoLink';

# Exemplos TLPP (PROBAT)

Código-fonte em <RepoLink id="${REPO_ID}" /> — \`src/\` (código testado) e \`test/\` (testes PROBAT).

Use esta seção **depois** da trilha conceitual do menu PROBAT — cada página lista arquivos \`.tlpp\` com link para o GitHub.

## Categorias

${indexLinks}

## Como usar os exemplos

1. Leia a página conceitual correspondente (ex.: [Asserts](/docs/tlpp/probat/asserts)).
2. Abra o arquivo \`.tlpp\` no repositório pelo link da tabela.
3. Configure o AppServer conforme [Configuração](/docs/tlpp/probat/configuracao) e execute com PROBAT.
`,
    'utf8',
  );

  console.log(
    `generate-exemplos-docs: ${categories.length + 1} páginas, ${manifest.length} arquivos .tlpp`,
  );
}

main();
