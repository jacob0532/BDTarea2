#pragma checksum "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "9381fc0ed1e98fab36aaa22bc266f40cea22f6f7"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Principal_verTipoCuenta), @"mvc.1.0.view", @"/Views/Principal/verTipoCuenta.cshtml")]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#nullable restore
#line 1 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\_ViewImports.cshtml"
using AppWebBD;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\_ViewImports.cshtml"
using AppWebBD.Models;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"9381fc0ed1e98fab36aaa22bc266f40cea22f6f7", @"/Views/Principal/verTipoCuenta.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"f23a3017679a57eb646949b40ff63d2e4c81b9fc", @"/Views/_ViewImports.cshtml")]
    public class Views_Principal_verTipoCuenta : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<AppWebBD.Models.TipoCuentaAhorro>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("\r\n");
#nullable restore
#line 3 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
  
    ViewData["Title"] = "verTipoCuenta";
    Layout = "~/Views/Shared/_LayoutUsuario.cshtml";

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n<h1>Detalles</h1>\r\n\r\n<div>\r\n    <h4>Tipo Cuenta Ahorro</h4>\r\n    <hr />\r\n    <dl class=\"row\">\r\n        <dt class=\"col-sm-2\">\r\n            Ahorro:\r\n        </dt>\r\n        <dd class=\"col-sm-10\">\r\n            ");
#nullable restore
#line 18 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
       Write(Html.DisplayFor(model => model.Nombre));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dd>\r\n        <dt class=\"col-sm-2\">\r\n            Saldo Minimo:\r\n        </dt>\r\n        <dd class=\"col-sm-10\">\r\n            ");
#nullable restore
#line 24 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
       Write(Html.DisplayFor(model => model.SaldoMinimo));

#line default
#line hidden
#nullable disable
#nullable restore
#line 24 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
                                                   Write(Html.DisplayFor(model => model.Simbolo));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dd>\r\n        <dt class=\"col-sm-2\">\r\n            Multa Por Saldo Minimo:\r\n        </dt>\r\n        <dd class=\"col-sm-10\">\r\n            ");
#nullable restore
#line 30 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
       Write(Html.DisplayFor(model => model.MultaSaldoMin));

#line default
#line hidden
#nullable disable
#nullable restore
#line 30 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
                                                     Write(Html.DisplayFor(model => model.Simbolo));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dd>\r\n        <dt class=\"col-sm-2\">\r\n            Cargo Anual:\r\n        </dt>\r\n        <dd class=\"col-sm-10\">\r\n            ");
#nullable restore
#line 36 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
       Write(Html.DisplayFor(model => model.CargoAnual));

#line default
#line hidden
#nullable disable
#nullable restore
#line 36 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
                                                  Write(Html.DisplayFor(model => model.Simbolo));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dd>\r\n        <dt class=\"col-sm-2\">\r\n            Retiros Fisicos:\r\n        </dt>\r\n        <dd class=\"col-sm-10\">\r\n            ");
#nullable restore
#line 42 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
       Write(Html.DisplayFor(model => model.NumRetirosHumano));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dd>\r\n        <dt class=\"col-sm-2\">\r\n            Retiros Cajero Automático:\r\n        </dt>\r\n        <dd class=\"col-sm-10\">\r\n            ");
#nullable restore
#line 48 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
       Write(Html.DisplayFor(model => model.NumRetirosAutomatico));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dd>\r\n        <dt class=\"col-sm-2\">\r\n            Comisión Fisica:\r\n        </dt>\r\n        <dd class=\"col-sm-10\">\r\n            ");
#nullable restore
#line 54 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
       Write(Html.DisplayFor(model => model.ComisionHumano));

#line default
#line hidden
#nullable disable
#nullable restore
#line 54 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
                                                      Write(Html.DisplayFor(model => model.Simbolo));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dd>\r\n        <dt class=\"col-sm-2\">\r\n            Comisión Cajero Autómatico:\r\n        </dt>\r\n        <dd class=\"col-sm-10\">\r\n            ");
#nullable restore
#line 60 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
       Write(Html.DisplayFor(model => model.ComisionAutomatico));

#line default
#line hidden
#nullable disable
#nullable restore
#line 60 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
                                                          Write(Html.DisplayFor(model => model.Simbolo));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dd>\r\n        <dt class=\"col-sm-2\">\r\n            Intereses:\r\n        </dt>\r\n        <dd class=\"col-sm-10\">\r\n            ");
#nullable restore
#line 66 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
       Write(Html.DisplayFor(model => model.Intereses));

#line default
#line hidden
#nullable disable
            WriteLiteral("%\r\n        </dd>\r\n        <dt class=\"col-sm-2\">\r\n            Cuenta en:\r\n        </dt>\r\n        <dd class=\"col-sm-10\">\r\n            ");
#nullable restore
#line 72 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
       Write(Html.DisplayFor(model => model.NombreMoneda));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </dd>\r\n    </dl>\r\n</div>\r\n<div>\r\n    ");
#nullable restore
#line 77 "C:\Users\yeico\Desktop\BaseDeDatos-Proyecto1\AppWebBD\Views\Principal\verTipoCuenta.cshtml"
Write(Html.ActionLink("<--Volver", "volverIndex", new { }));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n</div>\r\n");
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<AppWebBD.Models.TipoCuentaAhorro> Html { get; private set; }
    }
}
#pragma warning restore 1591