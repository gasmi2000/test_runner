#!/bin/bash
set -e

# Vérifier que les variables nécessaires sont présentes
if [ -z "$RUNNER_URL" ] || [ -z "$RUNNER_TOKEN" ]; then
  echo "❌ RUNNER_URL et RUNNER_TOKEN doivent être définis."
  exit 1
fi

# Configurer le runner (si pas déjà configuré)
if [ ! -f .runner ]; then
  echo "Configuration du runner..."
  ./config.sh --url "$RUNNER_URL" --token "$RUNNER_TOKEN" --unattended --replace
fi

# Lancer le runner
echo "Demarrage du runner GitHub Actions..."
exec ./run.sh
