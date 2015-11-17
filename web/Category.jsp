


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
        <title>JSP Page</title>
    </head>
    <body>
        
            <h1>Category List </h1>
    <% try{ 
        Connection c =connect();
        Statement stmt1 = c.createStatement();
        ResultSet rs1 = stmt1.executeQuery("Select * from category");


    %><thead>Category List</thead>
    <%   while (rs1.next()) {%>
    <table border="1" style="width:100%"> <col width="100"> <col width="100"><col width="100">


        <tbody><tr>
                <td><%out.println(rs1.getString(1));%></td> 
                <td><%out.println(rs1.getString(2));%></td> 
                <td><%out.println(rs1.getString(3));%></td> 

            </tr>
        </tbody>
    </table>  
    <%  }

            c.close();
        } catch (Exception e) {
        }%>
        
        
        
         <h1>Adding New Category</h1>



    <form name="name1" action="#" method="POST">
        <table border="1">


            <tr>
                <td>Category Name</td>
                <td><input type="text" name="cname" value="" size="50" autocomplete="off"/></td>
            </tr>
            <tr>
                <td>Category Description</td>
                <td><input type="text" name="cdesc" value="" size="50" autocomplete="off"/></td>
            </tr>

           
           
            <tr>
                <td><input type="submit" value="Add" name="btnadd"/></td>
                <td><input type="reset" value="Reset" name="btnreset" /></td>
            </tr>

        </table>
    </form>
    <%
        if (request.getMethod().equals("POST")) {
            String cname, cdesc;
            cname = request.getParameter("cname");
            cdesc = request.getParameter("cdesc");
            try {
                Connection c = connect();

                String sql = "insert into stocdatabase.category(CategoryName,Categorydesc)  values ('" + cname + "','" + cdesc + "')";

                Statement stmt1 = c.createStatement();
                stmt1.executeUpdate(sql);


                 
                c.close();

            } catch (Exception e) {
                out.print(e.getMessage());
            }
        }

    %>        


        
        
        
        
    </body>
</html>
