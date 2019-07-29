SSH_SRC_POINT=$SRC_PORT
if [[ $SRC_ADDR != "" ]]
then
    SSH_SRC_POINT=$SRC_ADDR:$SSH_SRC_POINT
fi

SSH_DST_POINT=$DST_PORT
if [[ $DST_ADDR == "" ]]
then
    DST_ADDR="0.0.0.0"
fi
SSH_DST_POINT=$DST_ADDR:$SSH_DST_POINT

SSH_CONNECTION_PROXY=$SSH_DST_POINT:$SSH_SRC_POINT

if [[ $ROTATE == "reverse" ]]; then
    SHORT_ROTATE='R'
else
    SHORT_ROTATE='L'
fi

while true; do
    ssh -N -$SHORT_ROTATE \
        $SSH_CONNECTION_PROXY \
        -p$SSH_PORT \
        $SSH_USER@$SSH_ADDR \
        -o ExitOnForwardFailure=yes \
        -o ServerAliveInterval=30 \
        -o ServerAliveCountMax=3
    echo 'Connection lost. Try again in 10 seconds.'
    sleep 10
done
