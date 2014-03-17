<html>
  <body>
    <table>
      <g:each in="${poi}" var="p">
        <tr>
          <td>${p.name}</td>
          <td>${p.geocode.response.postcode}</td>
          <td>${p.geocode.response.geo.lat}</td>
          <td>${p.geocode.response.geo.lng}</td>
        </tr>
      </g:each>
    </table>
  </body>
</html>
