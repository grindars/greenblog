Greenblog = {
    confirm: function(form, parameters) {
        if(typeof Greenblog.confirmCompletionQueue[form] !== "undefined") {
            var res = Greenblog.confirmCompletionQueue[form];
            delete Greenblog.confirmCompletionQueue[form];
            
            return res;
        } else {
            var exchange = {};
            
            var dialog = (function() {
                var dialog = document.createElement("div");
                dialog.className = "modal";
                
                var closeButton = document.createElement("button");
                closeButton.type = "button";
                closeButton.className = "close";
                closeButton.setAttribute("data-dismiss", "modal");
                closeButton.appendChild(document.createTextNode("\u00d7"));
                
                var title = document.createElement("h3");
                title.appendChild(document.createTextNode(parameters.title));
                
                var header = document.createElement("div");
                header.className = "modal-header";
                header.appendChild(closeButton);
                header.appendChild(title);
                
                var getClass = function(v) {
                    if(typeof v === "undefined")
                        return "btn";
                    else
                        return v;
                };
                
                var yesButton = document.createElement("button");
                yesButton.className = getClass(parameters.yesClass);
                yesButton.appendChild(document.createTextNode("Yes"));
                
                yesButton.onclick = function() {
                    delete yesButton.onclick;
                    
                    Greenblog.confirmCompletionQueue[form] = true;
                    
                    exchange.modal.modal("hide");
                };
                
                var noButton = document.createElement("button");
                noButton.className = getClass(parameters.noClass);
                noButton.appendChild(document.createTextNode("No"));
                noButton.setAttribute("data-dismiss", "modal");
                
                var buttonGroup = document.createElement("div");
                buttonGroup.className = "btn-group pull-right";
                buttonGroup.appendChild(yesButton);
                buttonGroup.appendChild(noButton);
                
                var body = document.createElement("div");
                body.className = "modal-body";
                body.appendChild(document.createTextNode(parameters.text));
                
                var footer = document.createElement("div");
                footer.className = "modal-footer";
                footer.appendChild(buttonGroup);
                
                dialog.appendChild(header);
                dialog.appendChild(body);
                dialog.appendChild(footer);
                
                return dialog;
            })();
            
            document.body.appendChild(dialog);
            
            var modal = $(dialog).modal("show");
            
            exchange.modal = modal;
            
            modal.one("hidden", function() {
                if(typeof Greenblog.confirmCompletionQueue[form] == "undefined")
                    Greenblog.confirmCompletionQueue[form] = false;
                
                document.body.removeChild(dialog);
                
                $(form).find('button[type="submit"], input[type="submit"]').click();
            });
            
            return false;
        }
    },
    
    confirmCompletionQueue: [],
    
    previewMarkup: function(form, target) {        
        for(var element = target.firstElementChild, next; element !== null; element = next) {
            next = element.nextElementSibling;
            
            target.removeChild(element);
        }
        
        var bar = document.createElement("div");
        bar.className = "bar";
        bar.style.width = "100%";
        
        var progress = document.createElement("div");
        progress.className = "progress progress-striped active";
        progress.appendChild(bar);
        
        var container = document.createElement("div");
        container.className = "well";
        container.appendChild(progress);
        
        target.appendChild(container);
                
        var data;
        
        if(typeof form["post[title]"] === "undefined") {
            data = {
                body:  form["comment[body]"].value
            };
        } else {
            data = {
                title: form["post[title]"].value,
                body:  form["post[body]"].value
            };
        }
        
        var xhr = $.ajax("/preview/convert.html", {
            complete: function(xhr, status) {
                container.removeChild(progress);
                $('html, body').animate({
                    scrollTop: $(target).offset().top
                }, 1500);                
                
                if(status == "success" || status == "notmodified") {                    
                    container.innerHTML = xhr.responseText;
                } else {                    
                    var error = document.createElement("div");
                    error.className = "alert alert-error";
                    error.appendChild(document.createTextNode(xhr.statusText));
                    
                    container.appendChild(error);
                }
            },
            data: data,
            type: 'POST'
        });
    }
};
