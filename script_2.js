let allStudents = [];

document.addEventListener('DOMContentLoaded', () => {
    const studentList = document.getElementById('student-list');

    async function fetchStudents() {
        const apiUrl = 'https://freetestapi.com/api/v1/students';
        try {
            const response = await fetch(apiUrl);
            const students = await response.json();
            allStudents = students;  
            console.log('Fetched students:', students.length);  // Debugging log
            displayStudents(students);
        } catch (error) {
            console.error('Failed to fetch student data:', error);
        }
    }

    function displayStudents(students) {
        studentList.innerHTML = '';
        console.log('Displaying students:', students.length);  
        students.forEach((student, index) => {
            console.log(`Processing student ${index + 1}:`, student);  
            const studentCard = document.createElement('div');
            studentCard.className = 'student-card';

            studentCard.innerHTML = `
                <img src="${student.image}" alt="${student.name}">
                <h2>${student.name}</h2>
                <p>ID: ${student.id}</p>
                <p>Age: ${student.age}</p>
                <p>Gender: ${student.gender}</p>
                <div class="address">
                    <strong>Address:</strong>
                    <p>${student.address.street}, ${student.address.city}, ${student.address.zip}, ${student.address.country}</p>
                </div>
                <div class="contact">
                    <p>Email: <a href="mailto:${student.email}">${student.email}</a></p>
                    <p>Phone: <a href="tel:${student.phone}">${student.phone}</a></p>
                </div>
                <div class="courses">
                    <strong>Courses:</strong>
                    <p>${student.courses[0]}</p>
                    <p>${student.courses[1]}</p>
                </div>
                <p>GPA: ${student.gpa}</p>
            `;

            studentList.appendChild(studentCard);
        });
    }

    function filterStudentsByGender(gender) {
        const filteredStudents = allStudents.filter(student => student.gender === gender);
        displayStudents(filteredStudents);
    }
    window.filterStudentsByGender = filterStudentsByGender;

    fetchStudents();
});
