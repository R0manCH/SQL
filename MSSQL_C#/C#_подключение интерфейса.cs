using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace BD3
{
    public partial class Form2 : Form
    {
        SqlConnection sqlConnection;
        SqlDataReader sqlReader = null;
        public Form2()
        {
            InitializeComponent();
        }

        private void Form2_Load(object sender, EventArgs e)
        {
            string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Visualka\BD3\BD3\ExampleData.mdf;Integrated Security=True";
            try
            {
                sqlConnection = new SqlConnection(connectionString);
                sqlConnection.Open();
                SqlCommand command = new SqlCommand("SELECT * FROM [Products]", sqlConnection);
                sqlReader = command.ExecuteReader();

                while (sqlReader.Read())
                {
                    listBox1.Items.Add(Convert.ToString(sqlReader["Id"]) + " " + Convert.ToString(sqlReader["Name"]) + " " +
                    Convert.ToString(sqlReader["Price"]));
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), ex.Source.ToString(),
                MessageBoxButtons.OK);
            }
            finally
            {
                if (sqlReader != null)
                    sqlReader.Close();
            }
        }

        private void Form2_FormClosed(object sender, FormClosedEventArgs e)
        {
            if (sqlConnection != null && sqlConnection.State != ConnectionState.Closed)
                sqlConnection.Close();  
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (label4.Visible) label4.Visible = false;
            if (!string.IsNullOrEmpty(textBox1.Text) &&
                !string.IsNullOrWhiteSpace(textBox1.Text) &&
                !string.IsNullOrEmpty(textBox2.Text) &&
                !string.IsNullOrWhiteSpace(textBox2.Text))
            {
                SqlCommand command = new SqlCommand("INSERT INTO[Products](Name, Price)VALUES(@Name, @Price)", sqlConnection);

                command.Parameters.AddWithValue("Name", textBox3.Text);
                command.Parameters.AddWithValue("Price", textBox2.Text);

                command.ExecuteNonQuery();
            }
            else
            {
                label4.Visible = true;
                label4.Text = "Поля 'Имя' и 'Цена' должны быть заполнены!";
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            listBox1.Items.Clear();
            if (sqlReader != null)
                sqlReader.Close();
            string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Visualka\BD3\BD3\ExampleData.mdf;Integrated Security=True";
            try
            {
                sqlConnection = new SqlConnection(connectionString);
                sqlConnection.Open();
                SqlCommand command = new SqlCommand("SELECT * FROM[Products]", sqlConnection);
                sqlReader = command.ExecuteReader();
                while (sqlReader.Read())
                {
                   listBox1.Items.Add(Convert.ToString(sqlReader["Id"]) + " " +
                   Convert.ToString(sqlReader["Name"]) + " " +
                   Convert.ToString(sqlReader["Price"]));
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), ex.Source.ToString(),
                MessageBoxButtons.OK);
            }
            finally
            {
                if (sqlReader != null)
                    sqlReader.Close();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (label5.Visible) label5.Visible = false;
            if (!string.IsNullOrEmpty(textBox12.Text) &&
            !string.IsNullOrWhiteSpace(textBox12.Text) &&
            !string.IsNullOrEmpty(textBox11.Text) &&
            !string.IsNullOrWhiteSpace(textBox11.Text) &&
            !string.IsNullOrEmpty(textBox13.Text) &&
            !string.IsNullOrWhiteSpace(textBox13.Text))
            {
                SqlCommand command = new SqlCommand("UPDATE [Products]SET[Name] = @Name, [Price] = @Price WHERE[Id] = @Id",sqlConnection);
                command.Parameters.AddWithValue("Id", textBox13.Text);
                command.Parameters.AddWithValue("Name", textBox12.Text);
                command.Parameters.AddWithValue("Price", textBox11.Text);
                command.ExecuteNonQuery();
            }
            else
            {
                label5.Visible = true;
                label5.Text = "Заполните все поля!";
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (label6.Visible) label6.Visible = false;
            if (!string.IsNullOrEmpty(textBox14.Text) &&
            !string.IsNullOrWhiteSpace(textBox14.Text))
            {
                SqlCommand command = new SqlCommand("DELETE FROM[Products] RESTART IDENTITY" +" WHERE [Id] = @Id", sqlConnection);
                command.Parameters.AddWithValue("Id", textBox14.Text);
                command.ExecuteNonQuery();
            }
            else
            {
                label6.Visible = true;
                label6.Text = "Заполните поле 'Id'!";
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            new Form3().Show();
        }
    }
}