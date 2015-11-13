
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
        <h1>List of Branches </h1>

        <% try {

                Connection c = connect();
                Statement stmt = c.createStatement();
                ResultSet rs = stmt.executeQuery("Select * from branch");

        %>

        <% while (rs.next()) {%>
        <table border="1" style="width:100%" >

            <col width="100"> <col width="100"><col width="100"><col width="100"><col width="100">
            <tr>
                <td><%out.println(rs.getString(1));%></td> 
                <td><%out.println(rs.getString(2));%></td> 
                <td><%out.println(rs.getString(3));%></td> 
                <td><%out.println(rs.getString(4));%></td> 
                <td><%out.println(rs.getString(5));%></td>             </tr>


        </table>  
        <%  }

                c.close();
            } catch (Exception e) {

            }%>

        <h1>Stock List</h1>

        <% try {

                Connection c = connect();
                Statement stmt = c.createStatement();
                ResultSet rs = stmt.executeQuery("Select * from stock");

        %>

        <% while (rs.next()) {%>
        <table border="1" style="width:100%"> <col width="100"> <col width="100"><col width="100"><col width="100">


            <tbody>
                <tr>
                    <td><%out.println(rs.getString(1));%></td> 
                    <td><%out.println(rs.getString(2));%></td> 
                    <td><%out.println(rs.getString(3));%></td> 
                    <td><%out.println(rs.getString(4));%></td> </tr>

            </tbody>
        </table>  
        <%  }

                c.close();
            } catch (Exception e) {

            }%>


        <h1>Product List </h1>

        <% try {

                Connection c = connect();
                Statement stmt = c.createStatement();
                ResultSet rs = stmt.executeQuery("Select idproduct,productname,productQuantity,prix,Rdate from product");

        %> 

        <% while (rs.next()) {%>
        <table border="1" style="width:100%"> <col width="100"> <col width="100"><col width="100"><col width="100"><col width="100">


            <tbody>
                <tr>
                    <td><%out.println(rs.getString(1));%></td> 
                    <td><%out.println(rs.getString(2));%></td> 
                    <td><%out.println(rs.getString(3));%></td> 
                    <td><%out.println(rs.getString(4));%></td> 
                    <td><%out.println(rs.getString(5));%></td>             </tr>

            </tbody>
        </table> 
        <%  }

                c.close();
            } catch (Exception e) {

            }%> 



        <h1>Adding Product to Specific Department</h1>

        <form name="name1" action="#" method="POST">
            <table border="1">



                <tr> 
                    <td>Product ID</td>
                    <td><input type="text" name="pid" value="" size="50" autocomplete="off"/></td>
                </tr>

                <tr>
                    <td>Department ID</td>
                    <td><input type="text" name="Did" value="" size="50" autocomplete="off"/></td>
                </tr>
                <tr>
                    <td>Product Quantity</td>
                    <td><input type="text" name="pquantity" value="" size="50" autocomplete="off"/></td>
                </tr>

                <tr>
                    <td><input type="submit" value="Add" name="btnadd"/></td>
                    <td><input type="reset" value="Reset" name="btnreset" /></td>
                </tr>

            </table>
        </form>
        <%int cout=0;
            if (request.getMethod().equals("POST")) {
                String pid, pquantity, pprice, Did;
                pid = request.getParameter("pid");
                pquantity = request.getParameter("pquantity");
                Did = request.getParameter("Did");

                try {
                    Connection c = connect();

                      Statement stmt3 = c.createStatement();
                ResultSet rs3 = stmt3.executeQuery("Select productQuantity from stocdatabase.product where idproduct="+pid+"");

                while (rs3.next()) {
                    cout = Integer.parseInt(rs3.getString(1));
                    request.setAttribute("ssss", cout);

                }
                    
                 int sqwe=Integer.parseInt( request.getAttribute("ssss").toString())-Integer.parseInt(pquantity);
                    if(sqwe>=0)
                    {
                    String sql121 = "insert into stocdatabase.proddep(pid,depid,pquantity)  values (" + pid + "," + Did + ","+pquantity+")";

                    Statement stmt2 = c.createStatement();
                    stmt2.executeUpdate(sql121);
                    
                      String sqlm = "update  stocdatabase.product  set productQuantity=" + sqwe + " where idproduct=" +pid+ "";

                    Statement stmt9 = c.createStatement();
                    stmt9.executeUpdate(sqlm);
                    
                    }
                    c.close();

                } catch (Exception e) {
                    out.print(e.getMessage());
                }
            }
        %>




    </body>
</html>
