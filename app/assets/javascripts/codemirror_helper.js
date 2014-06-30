//= require codemirror
//= require mode/ruby
//= require mode/clike
//= require keymap/sublime

var editors = []
var called = []

var hash = {
    mode: "ruby",
    theme: "mbo",
    tabSize: 2,
    lineNumbers: true,
    keymap: "sublime"
};

var hashPart = {
    mode: "clike",
    theme: "mbo",
    tabSize: 2,
    smartIndent: false,
    lineNumbers: true,
    keymap: "sublime"
}

var hashReadonly = {};
for (var i in hash)
    hashReadonly[i] = hash[i];
hashReadonly['readOnly'] = true;

function editorInit(id, readonly){
    return CodeMirror.fromTextArea(document.getElementById(id), readonly?hashReadonly:hash)
}

function editorReadonly(id){ editorInit(id,true); }

function editorNoRuby(id){
    return CodeMirror.fromTextArea(document.getElementById(id), hashPart)
}

function edtiorAccordion(id,isRuby){
    $(function () {
        if (called.indexOf(id) != -1) { return; }

        if(isRuby) {editors.push(editorInit(id,false));}
        else {editors.push(editorNoRuby(id));}
        called.push(id);
        setTimeout(function() {
            editors[editors.length-1].refresh();
        },0);
    });
}

function editorNoRubyAccordion(id){
    edtiorAccordion(id,false);
}

function editorRubyAccordion(id){
    edtiorAccordion(id,true);
}

