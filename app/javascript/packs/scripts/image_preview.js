window.addEventListener("turbolinks:load", () => {
    $(function () {
        $('#user_avatar').on('change', function (event) {
            var files = event.target.files;
            var image = files[0]
            // here's the file size
            console.log(image.size);
            var reader = new FileReader();
            reader.onload = function (file) {
                var img = new Image();
                console.log(file);
                img.src = file.target.result;
                $('#target')
                    .attr('src', file.target.result)

            }
            reader.readAsDataURL(image);
            console.log(files);
        });
    });
});