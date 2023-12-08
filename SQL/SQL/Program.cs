using System.Data.SqlClient;
using System;
using System.Xml.Linq;
using System.Threading.Channels;

namespace SQL
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //Connection to the database
            string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=school;Integrated Security=True";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                int Choice;
                do
                {
                    //Display menu options fo the user
                    Console.WriteLine("Chooce a number beetween 1-7");
                    Console.WriteLine("Do you want to see a list of all students? Press '1'");
                    Console.WriteLine("Do you want to see a list of all  Classes?  Press '2'");
                    Console.WriteLine("Do you want to add new personal in the school? Press '3'");
                    Console.WriteLine("Do you want to see a list of all personal in the school? Press '4'");
                    Console.WriteLine("Do you want to see all the grades that each student has received? Press '5'");
                    Console.WriteLine("Do you want to see a list average grade per course? Press '6'");
                    Console.WriteLine("Do you want to add a new student in the school? Press '7'");

                    if (!int.TryParse(Console.ReadLine(), out Choice) || Choice < 1 || Choice > 7)
                    {
                        Console.WriteLine("\nInvalid input. Please enter a number between 1 and 7.");
                    }


                    switch (Choice)
                    {
                        case 1:
                            GetStudents(connection);
                            Console.WriteLine("Press Enter to come main menu");
                            Console.ReadLine();
                            break;

                        case 2:
                            GetStudentOfClasse(connection);
                            Console.WriteLine("Press Enter to come main menu");
                            Console.ReadLine();
                            break;
                        case 3:
                            AddnewPersonal(connection);
                            Console.WriteLine("Press Enter to come main menu");
                            Console.ReadLine();
                            break;
                        case 4:
                            Getpersonal(connection);
                            Console.WriteLine("Press Enter to come main menu");
                            Console.ReadLine();
                            break;
                        case 5:
                            GetGrade(connection);
                            Console.WriteLine("Press Enter to come main menu");
                            Console.ReadLine();
                            break;
                        case 6:
                            GetAverage(connection);
                            Console.WriteLine("Press Enter to come main menu");
                            Console.ReadLine();
                            break;
                        case 7:
                            AddnewStudent(connection);
                            Console.WriteLine("Press Enter to come main menu");
                            Console.ReadLine();
                            break;

                    }

                } while (Choice != 7);

                static void GetStudents(SqlConnection connection)
                {
                    do
                    {

                        Console.WriteLine("Do you want to see a list of all students be sorted in ascending or descending. DESC/ASC");
                        string input = Console.ReadLine().ToUpper();

                        if (input == "DESC")
                        {
                            Console.WriteLine("List of all students are sorted in descending: ");
                            string SQDesc = "SELECT * FROM Students " +
                                             "ORDER BY StudentsName DESC ";
                            using (SqlCommand command = new SqlCommand(SQDesc, connection))
                            {
                                using (SqlDataReader reader = command.ExecuteReader())
                                {

                                    while (reader.Read())
                                    {

                                        Console.WriteLine("{0}\t{1}", reader.GetValue(0), reader.GetValue(1));
                                    }
                                }
                            }
                           
                        }
                        else if (input == "ASC")
                        {
                            Console.WriteLine("List of all students are sorted in ascending: ");
                            string SqAsc = "SELECT * FROM Students " + "ORDER BY StudentsName ASC";
                            using (SqlCommand command = new SqlCommand(SqAsc, connection))
                            {
                                using (SqlDataReader reader = command.ExecuteReader())
                                {
                                    while (reader.Read())
                                    {
                                        Console.WriteLine("{0}\t{1}", reader.GetValue(0), reader.GetValue(1));
                                    }
                                }
                            }
                            break;
                            
                            
                        }
                        else
                        {
                            Console.WriteLine("Invail choice. Choose Desc or asc");


                        }
                       
                    } while (true);

                }
                static void GetStudentOfClasse(SqlConnection connection)
                {
                    //Display all class in the school
                    Console.WriteLine("This is a lis of classes :");
                    string SqClasses = "Select * from Classes  ";
                    using (SqlCommand command = new SqlCommand(SqClasses, connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                Console.WriteLine("{0}\t{1}", reader.GetValue(0), reader.GetValue(1));

                            }
                        }
                    }
                    //Display all students on specific class
                    while (true)
                    {
                        Console.WriteLine("If you want see a list of students in .net23 press '1'");
                        Console.WriteLine("If you want see a list of students in UX press '2'");
                        Console.WriteLine("If you want back to the main menu '0'");
                        string StudentsOnClasses = Console.ReadLine();

                        if (StudentsOnClasses == "1" || StudentsOnClasses == "2")
                        {
                            string className = (StudentsOnClasses == "1") ? ".net23" : "UX";

                            while (true)
                            {
                                //Extera utmaning
                                //Students sorted by ascendig or descendig
                                Console.WriteLine($"Do you want to see students in class {className}  stored by Descendig or Ascendig? Enter Desc/Asc");
                                string input1 = Console.ReadLine().ToUpper();
                                if (input1 == "DESC" || input1 == "ASC")
                                {

                                    string sort = (input1 == "DESC") ? "DESC" : "ASC";

                                    string StudentsOnClassQuery = $"SELECT * FROM Students " +
                                                                    $"JOIN Classes ON Students.ClassesId_FK = Classes.ClassesID " +
                                                                    $"WHERE ClassesName = '{className}'" +
                                                                    $"ORDER BY StudentsName {sort}";
                                    using (SqlCommand command1 = new SqlCommand(StudentsOnClassQuery, connection))
                                    {
                                        using (SqlDataReader reader = command1.ExecuteReader())
                                        {
                                            while (reader.Read())
                                            {
                                                Console.WriteLine("{0}\t{1}", reader.GetValue(0), reader.GetValue(1));
                                            }
                                        }
                                    }
                                    break;

                                }
                                else
                                {
                                    Console.WriteLine("Invalid input. Please enter Desc or ASC");
                                }
                            }
                        }


                        else if (StudentsOnClasses == "0")
                        {
                            break;
                        }
                        else
                        {
                            Console.WriteLine("Invalid choice. Choose 1/2/0");
                        }
                    }        
                }
                static void AddnewPersonal(SqlConnection connection)
                {
                    Console.WriteLine("Add new teacher in the school");

                    Console.WriteLine("Enter Firstname");
                    string FirstName = Console.ReadLine();

                    Console.WriteLine("Enter Role");
                    string Role = Console.ReadLine();



                    String InsertQuery = "INSERT INTO Personal (FirstName, Role) VALUES (@FirstName, @Role)";

                    using (SqlCommand command = new SqlCommand(InsertQuery, connection))
                    {
                        command.Parameters.AddWithValue(@"FirstName", FirstName);
                        command.Parameters.AddWithValue(@"Role", Role);
                        command.ExecuteNonQuery();
                        Console.WriteLine("New techer added successfully");
                    }
                }
                static void Getpersonal(SqlConnection connection)
                    {
                    //Display prsonals who are in the school
                    while (true)
                    {

                        Console.WriteLine("Do you want see all employees or just teachers? Enter 1= all employees / 2= just teacher");
                        Console.WriteLine("If you want back to the menu of classes press '0'");

                        //Display all personal in the school
                        string input = Console.ReadLine();
                        if (input == "1")
                        {
                            Console.WriteLine("This is a list of all personal in the school");
                            using (SqlCommand command = new SqlCommand("SELECT * FROM Personal", connection))
                            {
                                using (SqlDataReader reader = command.ExecuteReader())
                                {
                                    while (reader.Read())
                                    {

                                        Console.WriteLine("{0}{1}", reader.GetValue(1), reader.GetValue(2));

                                    }
                                }
                            }
                        }
                        //Display just teachers in the school
                        else if (input == "2")
                        {
                            Console.WriteLine("This a list of Teachers");
                            using (SqlCommand command = new SqlCommand("SELECT * FROM Personal WHERE Role = 'Teacher'", connection))
                            {

                                using (SqlDataReader reader = command.ExecuteReader())
                                {
                                    while (reader.Read())
                                    {
                                        Console.WriteLine("{0}{1}", reader.GetValue(1), reader.GetValue(2));

                                    }
                                }
                            }

                        }
                        else if (input == "0")
                        {
                            return;
                        }
                        else
                        {
                            Console.WriteLine("Invalid choice. Choose 1/2/0");
                        }
                    }

                }
                static void GetGrade(SqlConnection connection)
                {
                    //Display Grades, courses, courses name and date for each students in the school
                    Console.WriteLine("This is a list of grades,studentsname and coursesname whits date that sudents have recived from the beginning: ");
                    string sqlQuery = "SELECT Grade, StudentsName, Courses.Name, GradeDate " +
                                      "FROM Grades " +
                                      "JOIN Students ON Grades.StudentsId_FK = Students.StudentsID " +
                                      "JOIN Courses ON Grades.CoursesId_FK = Courses.CoursesId ";
                    using (SqlCommand sqlCommand = new SqlCommand(sqlQuery, connection))
                    {

                        using (SqlDataReader sqlDataReader = sqlCommand.ExecuteReader())
                        {
                            while (sqlDataReader.Read())
                            {
                                Console.WriteLine("{0}\t{1}\t{2}\t{3}", sqlDataReader.GetValue(0), sqlDataReader.GetValue(1), sqlDataReader.GetValue(2), sqlDataReader.GetValue(3));
                            }
                        }
                    }
                    //Display  Grades, courses, and courses name for each students in the school in the last month
                    Console.WriteLine("This is a list of grades whits date that sudents have recived in the last month ");
                    string Q = "SELECT Grade, StudentsName, Courses.Name, GradeDate " +
                                      "FROM Grades " +
                                      "JOIN Students ON Grades.StudentsId_FK = Students.StudentsID " +
                                      "JOIN Courses ON Grades.CoursesId_FK = Courses.CoursesId " +
                                      "WHERE GradeDate = '2023-11-20'";
                    using (SqlCommand sqlCommand1 = new SqlCommand(Q, connection))
                    {
                        using (SqlDataReader reader = sqlCommand1.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                Console.WriteLine("{0}\t{1}\t{2}\t{3}", reader.GetValue(0), reader.GetValue(1), reader.GetValue(2), reader.GetValue(3));
                            }
                        }
                    }
                    
                }
                static void GetAverage(SqlConnection connection)
                {
                    //Display all courses and the average grade that students received
                    Console.WriteLine("This is a list with lowest, highest and average per cources that students have recived");
                    String SqlQuery = "SELECT Courses.Name AS CoursesName, " +
                                        "MIN(Grade) AS LowestGrade, " +
                                        "MAX(Grade) AS HighestGrade, " +
                                        "AVG(Grade) AS AverageGrade " +
                                        "FROM Grades " +
                                        "JOIN Courses ON Grades.CoursesId_FK = Courses.CoursesId " +
                                        "GROUP BY Courses.Name ";
                    using (SqlCommand command = new SqlCommand(SqlQuery, connection))
                    {
                        using (SqlDataReader sqlDataReader = command.ExecuteReader())
                        {
                            while (sqlDataReader.Read())
                            {

                                Console.WriteLine("\t{0}\t{1}\t{2}\t{3}", sqlDataReader.GetValue(0), sqlDataReader.GetValue(1), sqlDataReader.GetValue(2), sqlDataReader.GetValue(3));
                            }
                        }
                    }

                }
                static void AddnewStudent(SqlConnection connection)
                {
                    //Add a new student in the school
                    Console.WriteLine("Add new Student in the school");

                    Console.WriteLine("Enter Students name");
                    string Name = Console.ReadLine();

                    Console.WriteLine("Which class does the student fo to?");
                    Console.WriteLine("There are just two classes in the school, please Enter 1 for .net23 and 2 for UX: ");
                    string Class = Console.ReadLine();

                    string SqlQuery = "INSERT INTO Students (StudentsName, ClassesId_FK) Values (@StudentsName, @ClassesId_FK)";
                    SqlCommand command = new SqlCommand(SqlQuery, connection);
                    command.Parameters.AddWithValue("@StudentsName", Name);
                    command.Parameters.AddWithValue("@ClassesId_FK", Class);
                    Console.WriteLine("New student added successfully");
                    command.ExecuteNonQuery();

                }

            }
        }
    }
}








