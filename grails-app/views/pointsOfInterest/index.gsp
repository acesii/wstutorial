<html>
  <body>
    <table>
      <g:each in="${poi}" var="p">
        <tr>
          <td>${p.name}</td>
          <td>${p.geocode}</td>
        </tr>
      </g:each>
    </table>
  </body>
</html>
