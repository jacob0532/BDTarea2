#pragma checksum "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "613896b4a2e5fe5e1d8a7dd5522a6187c0a35c73"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Principal_mostrarMovimientos), @"mvc.1.0.view", @"/Views/Principal/mostrarMovimientos.cshtml")]
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
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"613896b4a2e5fe5e1d8a7dd5522a6187c0a35c73", @"/Views/Principal/mostrarMovimientos.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"f23a3017679a57eb646949b40ff63d2e4c81b9fc", @"/Views/_ViewImports.cshtml")]
    public class Views_Principal_mostrarMovimientos : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<IEnumerable<AppWebBD.Models.MovimientoCuentaAhorro>>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("\r\n");
#nullable restore
#line 3 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
  
    ViewData["Title"] = "mostrarMovimientos";
    Layout = "~/Views/Shared/_LayoutUsuario.cshtml";

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n<h1>Movimientos</h1>\r\n\r\n<table class=\"table\">\r\n    <thead>\r\n        <tr>\r\n            <th>\r\n                ");
#nullable restore
#line 14 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
           Write(Html.DisplayNameFor(model => model.id));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 17 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
           Write(Html.DisplayNameFor(model => model.Fecha));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 20 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
           Write(Html.DisplayNameFor(model => model.Monto));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 23 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
           Write(Html.DisplayNameFor(model => model.NuevoSaldo));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 26 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
           Write(Html.DisplayNameFor(model => model.EstadoCuentaid));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 29 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
           Write(Html.DisplayNameFor(model => model.Nombre));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 32 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
           Write(Html.DisplayNameFor(model => model.TipoOperacion));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 35 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
           Write(Html.DisplayNameFor(model => model.CuentaAhorroid));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
#nullable restore
#line 38 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
           Write(Html.DisplayNameFor(model => model.Descripcion));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            </th>\r\n            <th></th>\r\n        </tr>\r\n    </thead>\r\n    <tbody>\r\n");
#nullable restore
#line 44 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
         foreach (var item in Model)
        {

#line default
#line hidden
#nullable disable
            WriteLiteral("            <tr>\r\n                <td>\r\n                    ");
#nullable restore
#line 48 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
               Write(Html.DisplayFor(modelItem => item.id));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 51 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
               Write(Html.DisplayFor(modelItem => item.Fecha));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 54 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
               Write(Html.DisplayFor(modelItem => item.Monto));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 57 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
               Write(Html.DisplayFor(modelItem => item.NuevoSaldo));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 60 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
               Write(Html.DisplayFor(modelItem => item.EstadoCuentaid));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 63 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
               Write(Html.DisplayFor(modelItem => item.Nombre));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 66 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
               Write(Html.DisplayFor(modelItem => item.TipoOperacion));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 69 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
               Write(Html.DisplayFor(modelItem => item.CuentaAhorroid));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
#nullable restore
#line 72 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
               Write(Html.DisplayFor(modelItem => item.Descripcion));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </td>\r\n            </tr>\r\n");
#nullable restore
#line 75 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
        }

#line default
#line hidden
#nullable disable
            WriteLiteral("    </tbody>\r\n</table>\r\n\r\n");
#nullable restore
#line 79 "C:\Users\yeico\Desktop\BDTarea2\AppWebBD\Views\Principal\mostrarMovimientos.cshtml"
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
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<IEnumerable<AppWebBD.Models.MovimientoCuentaAhorro>> Html { get; private set; }
    }
}
#pragma warning restore 1591
