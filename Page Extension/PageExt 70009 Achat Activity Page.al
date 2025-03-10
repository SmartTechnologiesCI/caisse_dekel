// pageextension 70009 "Achat Activity Page Ext" extends 50017
// {
//     layout
//     {
//         // Add changes to page layout here
//         addlast(Activies)
//         {
//             field("Factures douanieres"; rec."Factures douanieres")
//             {
//                 ApplicationArea = All;
//                 DrillDown = true;
//                 Caption = 'Facture douanieres';
//                 Visible = false;

//                 trigger OnDrillDown()
//                 var
//                     myInt: Integer;
//                     salesInvoiceHeader: Record "Sales Invoice Header";
//                 begin
//                     salesInvoiceHeader.SetRange("Est Echantillone", true);
//                     salesInvoiceHeader.SetRange("Due Date", WorkDate());
//                     salesInvoiceHeader.FindSet();
//                     Page.Run(143, salesInvoiceHeader);
//                 end;

//             }
//             field("Contrats Non payés"; rec."Contrats Non payés")
//             {

//                 Visible = false;
//                 trigger OnDrillDown()
//                 var
//                     pHeader: record "Purchase Header";
//                 begin
//                     // silue samuel 07/03/2025 pHeader.SetRange("Statut paiement", pHeader."Statut paiement"::Unpaid);
//                     // silue samuel 07/03/2025 pHeader.SetFilter(Avance, '<=0');
//                     Page.run(Page::"Purchase Order List", pHeader);
//                 end;
//             }
//             field("Contrats partiellement payés"; rec."Contrats Partiellement payés")
//             {

//                 Visible = false;
//                 trigger OnDrillDown()
//                 var
//                     pHeader: record "Purchase Header";
//                 begin
//                     // pHeader.SetRange("Statut paiement", pHeader."Statut paiement"::Unpaid);
//                     //  silue samuel 07/03/2025 pHeader.SetFilter(Avance, '>0');
//                     Page.run(Page::"Purchase Order List", pHeader);
//                 end;
//             }
//             field("Contrats payés"; rec."Contrats payés")
//             {

//                 Visible = false;
//                 trigger OnDrillDown()
//                 var
//                     pHeader: record "Purchase Header";
//                 begin
//                     // silue samuel 07/03/2025 pHeader.SetRange("Statut paiement", pHeader."Statut paiement"::Paid);
//                     Page.run(Page::"Purchase Order List", pHeader);
//                 end;
//             }
//         }
//     }

//     actions
//     {
        
//     }

//     var
//         myInt: Integer;
// }