# How to Correct Committer Information in Git

When you need to correct the committer information in your Git repository, follow these steps. However, be cautious, as modifying commit history using `git filter-branch` and forcefully pushing changes might have significant consequences. I reccommend you to have a **backup** of the project on case something goes wrong so that you can force push that version to the branch again.

## Disclaimer

Use this script with caution, especially in collaborative environments. Changing commit messages can affect the commit history and may cause conflicts if others have already pulled the original commits.

## Understand the Implications:

- **Loss of Commit History:** Modifying commit information generates new commits, replacing the old ones and rewriting the commit history.
- **Collaboration Challenges:** Rewriting history may lead to synchronization issues in collaborative environments.
- **Disruption of Integrations:** Modifying commit history can disrupt integrations with tools like CI pipelines, issue trackers, and code review systems.

## Important Notes Before Use

- Ensure that you are on a branch containing the commit you want to modify.
- The script will not work if the branch is set as protected. Make sure you have the necessary permissions.

## Running the Bash Script Directly Without Cloning

You can run the provided Bash script directly without the need to clone the repository. Simply copy and paste the script from [my website](https://indomet.github.io/posts/how-to-fix-wrong-committer/) into your terminal and follow those steps there. Otherwise follow the enxt steps here.

## 1. Clone the Repository:

```bash
git clone git@github.com:Indomet/Useful-Bash-Scripts.git
cd Useful-Bash-Scripts/change-commit-author
```

Place the repository you wish to  the history of inside this folder.

## 2. Make the Script Executable:

Navigate to your Git repository that you want to edit, and execute:

```bash
chmod +x ./change_commit_message.sh
```

## 3. Run the Command:

```bash
./change_commit_author.sh
```

By following these steps, you can correct inaccurate committer information in your Git repository. Exercise caution and proceed only if you fully comprehend the potential consequences of modifying commit history, as this process rewrites the entire history and overrides the Git history in your GitHub branch.
