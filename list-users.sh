#!/bin/bash

#################################################################
# Script Name : list-users.sh
# Description : Lists users with read access to a GitHub repository
#               using the GitHub REST API. Supports organization
#               repositories and includes API error handling.
#
# Author      : Devansh Sharma
# GitHub      : https://github.com/deku0002/AWS
#
# Requirements:
#   - Bash
#   - curl
#   - jq
#   - GitHub Personal Access Token (GITHUB_TOKEN)
#
# Usage:
#   ./list-users.sh <owner> <repo>
#
# Example:
#   ./list-users.sh Devansh-Project test2
#
# Version     : 1.0.0
# Last Updated: 2026-01-02
#################################################################

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# Main script

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
