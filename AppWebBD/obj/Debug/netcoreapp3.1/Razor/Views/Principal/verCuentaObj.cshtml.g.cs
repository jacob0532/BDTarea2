#pragma checksum "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "419f337bfe64932d68f3ee9b680a3e970db953fc"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Principal_verCuentaObj), @"mvc.1.0.view", @"/Views/Principal/verCuentaObj.cshtml")]
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
#line 1 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\_ViewImports.cshtml"
using AppWebBD;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\_ViewImports.cshtml"
using AppWebBD.Models;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"419f337bfe64932d68f3ee9b680a3e970db953fc", @"/Views/Principal/verCuentaObj.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"f23a3017679a57eb646949b40ff63d2e4c81b9fc", @"/Views/_ViewImports.cshtml")]
    public class Views_Principal_verCuentaObj : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<IEnumerable<AppWebBD.Models.CuentaObjetivo>>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("\r\n");
#nullable restore
#line 3 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
  
    ViewData["Title"] = "verCuentaObj";
    Layout = "~/Views/Shared/_LayoutUsuario.cshtml";

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n<h1>Cuenta Objetivo</h1>\r\n\r\n\r\n<table class=\"table\">\r\n    <thead>\r\n        <tr>\r\n            <th>\r\n                ");
#nullable restore
#line 15 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
           Write(Html.DisplayNameFor(model => model.id));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 18 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
           Write(Html.DisplayNameFor(model => model.FechaInicio));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 21 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
           Write(Html.DisplayNameFor(model => model.FechaFin));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 24 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
           Write(Html.DisplayNameFor(model => model.Costo));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 27 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
           Write(Html.DisplayNameFor(model => model.Objetivo));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 30 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
           Write(Html.DisplayNameFor(model => model.Saldo));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 33 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
           Write(Html.DisplayNameFor(model => model.InteresesAcumulados));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 36 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
           Write(Html.DisplayNameFor(model => model.CuentaAhorroid));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th></th>\r\n        </tr>\r\n    </thead>\r\n    <tbody>\r\n");
#nullable restore
#line 42 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
         foreach (var item in Model)
        {

#line default
#line hidden
#nullable disable
            WriteLiteral("            <tr>\r\n                <td>\r\n                    ");
#nullable restore
#line 46 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
               Write(Html.DisplayFor(modelItem => item.id));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 49 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
               Write(Html.DisplayFor(modelItem => item.FechaInicio));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 52 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
               Write(Html.DisplayFor(modelItem => item.FechaFin));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 55 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
               Write(Html.DisplayFor(modelItem => item.Costo));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 58 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
               Write(Html.DisplayFor(modelItem => item.Objetivo));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 61 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
               Write(Html.DisplayFor(modelItem => item.Saldo));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 64 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
               Write(Html.DisplayFor(modelItem => item.InteresesAcumulados));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 67 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
               Write(Html.DisplayFor(modelItem => item.CuentaAhorroid));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 70 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
               Write(Html.ActionLink("Cambiar Descripcion", "editarCuentaObj", new {id = item.id }));

#line default
#line hidden
#nullable disable
            WriteLiteral("<br />\r\n                    ");
#nullable restore
#line 71 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
               Write(Html.ActionLink("Desactivar", "desactivarCuentaObj", new { id= item.id }));

#line default
#line hidden
#nullable disable
            WriteLiteral(" \r\n                </td>\r\n            </tr>\r\n");
#nullable restore
#line 74 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
        }

#line default
#line hidden
#nullable disable
            WriteLiteral("    </tbody>\r\n</table>\r\n");
#nullable restore
#line 77 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\verCuentaObj.cshtml"
Write(Html.ActionLink("<--Volver", "volverIndex", new { }));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n");
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
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<IEnumerable<AppWebBD.Models.CuentaObjetivo>> Html { get; private set; }
    }
}
#pragma warning restore 1591