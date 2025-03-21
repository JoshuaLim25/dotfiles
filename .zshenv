# Add Rust, Go to $PATH
. "$HOME/.cargo/env"
# export PATH="$PATH:$(go env GOPATH)/bin"
# export PATH=$PATH:/usr/local/go/bin

export RUST_BACKTRACE=1
export DOCKER_BUILDKIT=1

# See https://web.archive.org/web/20210506080335/https://mah.everybody.org/docs/ssh and https://stackoverflow.com/questions/18880024/start-ssh-agent-on-login
# SSH_ENV="$HOME/.ssh/ssh-agent-env"
#
# function start_agent() {
#     echo "Initialising new SSH agent..."
#     /usr/bin/ssh-agent | sed 's/^echo/#echo/' >"$SSH_ENV" && echo Succeeded
#     chmod 600 "$SSH_ENV"
#     . "$SSH_ENV" >/dev/null
#     /usr/bin/ssh-add;
# }
#
# # Source SSH settings, if applicable
# if [ -f "$SSH_ENV" ]; then
#     . "$SSH_ENV" >/dev/null
#     #ps $SSH_AGENT_PID doesn't work under Cygwin
#     ps -ef | grep $SSH_AGENT_PID | grep ssh-agent$ >/dev/null || {
#         start_agent
#     }
# else
#     start_agent
# fi
