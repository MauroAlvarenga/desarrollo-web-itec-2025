document.addEventListener('DOMContentLoaded', function () {
    const toggleBtn = document.getElementById('toggleDogBtn');
    const dogImg = document.getElementById('dogImage');

    toggleBtn.addEventListener('click', function () {
        if (dogImg.style.display === 'none' || dogImg.style.display === '') {
            dogImg.style.display = 'block';
        } else {
            dogImg.style.display = 'none';
        }
    });
});