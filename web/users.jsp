
<%@page  import ="java.sql.*"%>
<%!
    public static Connection connect() {

        try {

            Class.forName("com.mysql.jdbc.Driver").newInstance();

            return DriverManager.getConnection("jdbc:mysql://localhost/stocdatabase", "root", "root");
        } catch (Exception e) {
            return null;
        }

    }

    public static boolean close(Connection c) {
        try {
            c.close();
            return true;
        } catch (Exception e) {
            return false;
        }
    }


%>           

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Employee Management</title>
    </head>
    <body>
        <h1>Employee List</h1>

        <% try {

                Connection c = connect();
                Statement stmt = c.createStatement();
                ResultSet rs = stmt.executeQuery("Select * from user");

        %>

        <% while (rs.next()) {%>
        <table border="1" style="width:100%"> <col width="100"> <col width="100"><col width="100"><col width="100"><col width="100"><col width="100"><col width="100">



            <tr>
                <td><%out.println(rs.getString(1));%></td> 
                <td><%out.println(rs.getString(2));%></td> 
                <td><%out.println(rs.getString(3));%></td> 
                <td><%out.println(rs.getString(4));%></td> 
                <td><%out.println(rs.getString(5));%></td>  <td><%out.println(rs.getString(6));%></td>  <td><%out.println(rs.getString(7));%></td>             </tr>


        </table>  
        <%  }

                c.close();
            } catch (Exception e) {

            }
        %>

        <h1>Adding a new Employee</h1>    
        <form name="name1" action="#" method="POST">
            <table border="1">


                <tr>
                    <td>Employee Name :</td>
                    <td><input type="text" name="ename" value="" size="50" autocomplete="off"/></td>
                </tr>

                <tr>
                    <td>Employee Phone :</td>
                    <td><input type="text" name="ephone" value="" size="50" autocomplete="off"/></td>
                </tr>

                <tr>
                    <td>Employee Email :</td>
                    <td><input type="text" name="eemail" value="" size="50" autocomplete="off"/></td>
                </tr>

                <tr>
                    <td>Employee username :</td>
                    <td><input type="text" name="eusername" value="" size="50" autocomplete="off"/></td>
                </tr>
                <tr>
                    <td>Employee Password</td>
                    <td><input type="text" name="epass" value="" size="50" autocomplete="off"/></td>
                </tr>

                <tr>
                    <td>Employee Role</td>
                    <td><input type="text" name="erole" value="" size="50" autocomplete="off"/></td>
                </tr>
                  <tr>
                    <td>Stock id:</td>
                    <td><input type="text" name="stkid" value="" size="50" autocomplete="off"/></td>
                </tr>
                
                
                <tr>
                    <td><input type="submit" value="Add" name="btnadd"/></td>
                    <td><input type="reset" value="Reset" name="btnreset" /></td>
                </tr>

            </table>
        </form>

        <% if (request.getMethod().equals("POST")) {
                String ename, ephone, eemail, eusername, epass, erole,stkid;
                ename = request.getParameter("ename");
                ephone = request.getParameter("ephone");
                eemail = request.getParameter("eemail");
                eusername = request.getParameter("eusername");
                epass = request.getParameter("epass");
                erole = request.getParameter("erole");
                stkid=request.getParameter("stkid");
                try {
                    Connection c = connect();

                    String sql = "insert into stocdatabase.user(username,password,role,email,phone,Name,Stockid)  values ('" + eusername + "','" + epass + "','" + erole + "','" + eemail + "','"+ephone+"','"+ename+"','"+stkid+"')";

                    Statement stmt1 = c.createStatement();
                    stmt1.executeUpdate(sql);

                    c.close();

                } catch (Exception e) {
                    out.print(e.getMessage());
        }
    }%>

    </body></html>
