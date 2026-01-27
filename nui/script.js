let config = [];

window.addEventListener('message', function (event) {
    const data = event.data;

    if (data.type === "open") {
        setupMenu(data.items, data.colors);
        $("#app").fadeIn(300);
        updateState(data.states);
    } else if (data.type === "close") {
        $("#app").fadeOut(300);
    } else if (data.type === "updateState") {
        updateState(data.states);
    } else if (data.type === "notification") {
        showNotification(data.message);
    } else if (data.type === "updatePositions") {
        updatePositions(data.items);
    }
});

function updatePositions(items) {
    items.forEach((item, index) => {
        const el = $(`.menu-item[data-id="${index}"]`);
        if (el.length > 0) {
            el.css({
                left: item.x + '%',
                top: item.y + '%'
            });
        }
    });
}

function showNotification(msg) {
    let notif = $(`<div class="notification">${msg}</div>`);
    $("body").append(notif);
    notif.fadeIn(300).delay(2000).fadeOut(300, function () {
        $(this).remove();
    });
}

function setupMenu(items, colors) {
    const container = $("#radial-menu");
    container.empty();
    if (colors) {
        document.documentElement.style.setProperty('--primary', colors.primary);
        document.documentElement.style.setProperty('--secondary', colors.secondary);
        document.documentElement.style.setProperty('--accent', colors.accent);
        document.documentElement.style.setProperty('--text', colors.text);
    }
    items.forEach((item, index) => {
        const x = item.x || 50;
        const y = item.y || 50;
        const size = item.size || 70;
        let content = `<span class="iconify" data-icon="${item.icon}" data-width="${size * 0.5}" data-height="${size * 0.5}"></span>`;
        const el = $(`<div class="menu-item" data-id="${index}" style="left: ${x}%; top: ${y}%; width: ${size}px; height: ${size}px; font-size: ${size * 0.4}px;">${content}</div>`);
        el.on('mouseenter', () => {
            const label = $("#item-label");
            label.text(item.label);
            const offset = el.offset();
            const width = el.width();
            label.css({
                top: (offset.top - 45) + 'px',
                left: (offset.left + (width / 2)) + 'px',
                transform: 'translateX(-50%)'
            }).addClass("show");
        });
        el.on('mouseleave', () => {
            $("#item-label").removeClass("show");
        });
        el.on('click', () => {
            $.post(`https://${GetParentResourceName()}/toggleItem`, JSON.stringify({
                index: index
            }));
        });
        container.append(el);
    });
}

function updateState(states) {
    $(".menu-item").each(function () {
        const id = $(this).data("id");
        if (states[id]) {
            $(this).removeClass("off").addClass("active");
        } else {
            $(this).addClass("off").removeClass("active");
        }
    });
}

$(document).keyup(function (e) {
    if (e.key === "Escape" || e.key === "Backspace") {
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
    }
});
