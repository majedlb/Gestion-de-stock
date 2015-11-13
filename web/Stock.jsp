
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
        <title>Stock Information</title>
    </head>
    <body>
        <h1>Stock List</h1>
        
        <% try {

                Connection c = connect();
                Statement stmt = c.createStatement();
                ResultSet rs = stmt.executeQuery("Select * from stock");

               %>
                
               <% while (rs.next()) {%>
        <table border="1"style="width:100%"> <col width="100"> <col width="100"><col width="100"><col width="100">

           
            
                <tr>
                    <td><%out.println(rs.getString(1));%></td> 
                    <td><%out.println(rs.getString(2));%></td> 
                    <td><%out.println(rs.getString(3));%></td> 
                    <td><%out.println(rs.getString(4));%></td> </tr>

          
        </table>  
        <%  }

                c.close();
            } catch (Exception e) {
                
            }%>
            
            <h1>Adding New Stock to Specific Branch</h1>



        <form name="name1" action="#" method="POST">
            <table border="1">


                <tr >
                    <td>Stock Name :</td>
                    <td><input type="text" name="sname" value="" size="50" autocomplete="off"/></td>
                </tr>
                <tr>
                    <td>Stock Phone :</td>
                    <td><input type="text" name="sphone" value="" size="50" autocomplete="off"/></td>
                </tr>

                <tr>
                    <td>Branch id :</td>
                    <td><input type="text" name="bid" value="" size="50" autocomplete="off"/></td>
                </tr>

              

              

                <tr>
                    <td><input type="submit" value="Add" name="btnadd"/></td>
                    <td><input type="reset" value="Reset" name="btnreset" /></td>
                </tr>

            </table>
        </form>
        <%
            if (request.getMethod().equals("POST")) {
                String sname, sphone, bid;
                sname = request.getParameter("sname");
                sphone = request.getParameter("sphone");
                bid= request.getParameter("bid");
                              
 try {
       Connection c=connect();  
         
         String sql="insert into stocdatabase.branch(Stockname,Stockphone,bid)  values ('"+sname+"','"+sphone+"',"+bid+")";
       
         Statement stmt1 = c.createStatement();
         stmt1.executeUpdate(sql);
         
        
         c.close();
         
         
         }catch (Exception e){out.print(e.getMessage());}
            }

        %>        

            
            
            
            
        
    </body>
</html>
