let resourceName = 'radio'

$(function(){
    let radioOpen = false
    window.addEventListener('message', (event) => {
        if (event.data.type == 'showradio'){
            radioOpen = !radioOpen
            if (event.data.toggle === true) {
                $('.radioUI').show()
            } else {
                $('.radioUI').hide()
            }
        } else if (event.data.type === 'setFrequence'){
            $('.radioState').html(event.data.data)
        } else if (event.data.type === 'showIconsRadioOn') {
            $('#radioHZ').show()
            $('#radioNetwork').show()
        } else if (event.data.type === 'showMuteIcon'){
            if (event.data.toggle) {
                $('#radioMute').show()
                $('#radioRec').hide()
            } else {
                $('#radioRec').show()
                $('#radioMute').hide()
            }
        } else if (event.data.type === 'indicatorMode') {
            $('.voiceIndicator').show()
            $('.voiceIndicator').css('background-image', "url('./img/" + event.data.mode + ".png')")
        } else if (event.data.type === 'hideIndicator') {
            $('.voiceIndicator').hide()
        }
    });

    window.addEventListener('keydown', (e) => {
        if (e.keyCode == 80) {
            $.post('https://radio/closeRadio')
        }
    })

});

$('#radioManual').click(() => {
    $.post(`https://${resourceName}/requestFreq`)
})

$('#radioFreq').click(() => {
    $.post(`https://${resourceName}/enterFreq`, JSON.stringify({
        freq: $('.radioState').text()
    }))
})

$('#radioButtonMute').click(() => {
    $.post(`https://${resourceName}/muteRadio`)
})

$("#radioToggle").click(() => {
    $('.radioState').html('')
    $('#radioRec').hide()
    $('#radioMute').hide()
    $('#radioHZ').hide()
    $('#radioNetwork').hide()
    $.post(`https://${resourceName}/offRadio`)
})

$('#radioUP').click(() => {
    $.post(`https://${resourceName}/volumeUp`)
})

$('#radioDown').click(() => {
    $.post(`https://${resourceName}/volumeDown`)
})
