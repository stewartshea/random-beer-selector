node {
    stage 'build'
        openshiftBuild(bldCfg: 'random beer selector')

    stage 'ask for deployment'
        input id: 'Approve01', message: 'Wanna deploy?????', ok: 'HANG TIGHT!'
        
    stage 'deploy'
        sh "oc rollout latest dc/random beer selector"

}
