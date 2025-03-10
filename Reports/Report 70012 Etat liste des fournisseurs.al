// report 70012 "Fournisseur a payer"
// {

//     ApplicationArea = All;
//     UsageCategory = ReportsAndAnalysis;
//     PreviewMode = PrintLayout;
//     DataAccessIntent = ReadOnly;
//     Caption = 'Fournisseur a payer';
//     RDLCLayout = 'Reports\RDLC\Report 70012 Etat liste des fournisseur.rdlc';


//     dataset
//     {
//         dataitem("Purchase Header"; "Purchase Header")
//         {
//             column(No_; "No.")
//             {

//             }


//             column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
//             {

//             }
//             column(Buy_from_Vendor_No_; buyFromVendorNo)
//             {

//             }
//             //  silue samuel 07/03/2025 column(Statut_paiement; "Statut paiement")
//             // {

//             // }
//             column(Amount; Amount)
//             {

//             }
//             column(Payment_Terms_Code; "Payment Terms Code")
//             {

//             }
//             column(duedate; duedate)
//             {

//             }
//             column(paymentTermsText; paymentTermsText)
//             {

//             }
//             column(payerUrgement; payerUrgement)
//             {

//             }
//             column(echeanceEnJour; echeanceEnJour)
//             {

//             }
//             column(Posting_Date; "Posting Date") { }
//             column(montantCFA; montantCFA) { }
//             column(Currency_Code; "Currency Code") { }
//             column(Currency_Factor; "Currency Factor") { }
//             column(dateDebut; dateDebut) { }

//             column(dateFin; dateFin) { }
//             column(delaiExpiration; delaiExpiration)
//             {

//             }
//             column(viewDateOnRepport; viewDateOnRepport) { }
//             column(Autorisation_de_change; "Autorisation de change") { }
//             column(Banque; Banque) { }






//             trigger OnPreDataItem()
//             var
//                 myInt: Integer;
//             begin



//                 if (Format(dateDebut) <> '') and (Format(dateFin) <> '') then begin
//                     SetRange("Due Date", dateDebut, dateFin);
//                 end else begin
//                     dateDebut := DMY2Date(01, 01, 1900);
//                     dateFin := CalcDate('+365J', WorkDate());
//                     viewDateOnRepport := true;

//                 end;

//             end;



//             trigger OnafterGetRecord()
//             var
//                 myInt: Integer;
//                 newDueDate: Date;
//                 purchaseHeader: Record "Purchase Header";
//                 delais: Text[100];


//             // begin



//                 //Test si le numero du vendeur est null
//                 // if ("Purchase Header"."Buy-from Vendor No." <> '') then begin
//                 //     buyFromVendorNo := "Purchase Header"."Buy-from Vendor No."
//                 // end;
//                 //"Purchase Header".SetRange("Buy-from Vendor No.", buyFromVendorNo);

//                 /*
//                 DUE DATE
//                 */
//                 // vendor.Reset();
//                 // vendor.SetRange("No.", "Buy-from Vendor No.");

//                 // /*   if payerUrgement = true then begin

//                 //       SetFilter("Due Date", '<=%1', CalcDate('7J', WorkDate()));
//                 //       SetFilter("Due Date", '>%1', WorkDate());

//                 //   end; */
//                 // //SetFilter("Due Date", '<=%1', CalcDate('7J', WorkDate()));
//                 // // SetFilter("Due Date", '>%1', WorkDate());



//                 // if (vendor.FindFirst()) then begin
//                 //     if (vendor."Payment Terms Code" <> '') then begin
//                 //         paymentTerm.get(vendor."Payment Terms code");
//                 //         paymentTerm.Find();
//                 //         paymentTermsText := paymentTerm.Description;
//                 //     end;



//                     // if (paymentTerm."ref date type" = paymentTerm."ref date type"::ETA) then begin

//                     //     if (ETA <> 0D) then begin
//                     //         dueDate := CalcDate(paymentTerm."Due Date Calculation", ETA);
//                     //     end;

//                     // end
//                 //     else
//                 //         if (paymentTerm."ref date type" = paymentTerm."ref date type"::ETD) then begin
//                 //             if (ETD <> 0D) then begin
//                 //                 dueDate := CalcDate(paymentTerm."Due Date Calculation", ETD);
//                 //             end;
//                 //         end
//                 //         else
//                 //             if (paymentTerm."ref date type" = paymentTerm."ref date type"::ETS) then begin
//                 //                 if (ETS <> 0D) then begin
//                 //                     dueDate := CalcDate(paymentTerm."Due Date Calculation", ETS);
//                 //                 end;
//                 //             end
//                 //             else
//                 //                 if (paymentTerm."ref date type" = paymentTerm."ref date type"::BL) then begin

//                 //                     if ("Date livraison" <> 0D) then begin
//                 //                         dueDate := CalcDate(paymentTerm."Due Date Calculation", "Date livraison");
//                 //                     end;
//                 //                 end;
//                 // end;

//                 if payerUrgement = true then begin

//                     //SetFilter("Due Date", '<=%1', CalcDate('7J', WorkDate()));
//                     //SetFilter("Due Date", '>%1', WorkDate());
//                     if (dueDate > CalcDate('30J', WorkDate())) then begin
//                         // CurrReport.Skip();
//                     end;

//                     // SetRange("Due Date", '>%1', WorkDate());


//                 end;
//                 //Mise a jour de l'avance


//                 if paramettreComptable.Get() then;

//                 //  silue samuel 07/03/2025 if "Currency Code" = '' then
//                 //     montantCFA := "Purchase Header".Amount - "Purchase Header".Avance
//                 // else
//                 //     if "Currency Code" = 'EUR' then
//                 //         montantCFA := "Purchase Header".Amount * paramettreComptable."Taux de change Eur - CFA" - "Purchase Header".Avance


//                 //     else
//                 //         if "Currency Code" = 'USD' then
//                 //  fin silue samuel 07/03/2025           montantCFA := "Purchase Header".Amount * paramettreComptable."Taux de change USD - CFA" - "Purchase Header".Avance;



//                 /*
//                 TODO: DELAIS DE PAIEMENT
//                 */


//                 //delaiExpiration := CalcDate('-4J', "Due Date");
//                 delaiExpiration := (dueDate - WorkDate());
//                 // TODO: Paiement a effectuer les unpaid
//                 //  silue samuel 07/03/2025if "Purchase Header"."Statut paiement" = "Statut paiement"::Paid then
//                 //     CurrReport.Skip();
// //fin silue samuel


//                 //paymentTerm.SetRange(Code, "Payment Terms Code");
//                 /*   if paymentTerm.FindFirst() then begin
//                       repeat
//                           paymentTermsText := paymentTerm.Description;
//                       until paymentTerm.Next = 0;

//                   end; */


//                 /*    if "Purchase Header"."Statut paiement" = false then begin

//                        if paymentTerm."ref date type" = paymentTerm."ref date type"::BL then
//                        begin
//                            if purchaseHeader."Date livraison" > WorkDate() then begin

//                            end;
//                        end;

//                    end; */




//             end;


//         }


//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 /*   group(DateDebut)
//                    {
//                             field(Name; SourceExpression)
//                            {
//                                ApplicationArea = All;

//                            } 
//                    }
//                   */
//                 field(dateDebut; dateDebut)
//                 {
//                     Caption = 'Du :';
//                 }
//                 field(dateFin; dateFin)
//                 {
//                     Caption = 'au';
//                 }
//                 /*     field(payerUrgement; payerUrgement)
//                     {
//                         Caption = 'A payer urgement';
//                     } */

//             }
//         }

//         actions
//         {
//             area(processing)
//             {
//                 action(ActionName)
//                 {
//                     ApplicationArea = All;

//                 }
//                 /*    action(A_payer_urgement)
//                    {
//                        Caption = 'A regler urgement';

//                    } */
//             }
//         }
//     }


//     var
//         myInt: Integer;
//         dateDebut: Date;
//         dateFin: Date;
//         purchaseHeader: Record "Purchase Header";
//         paymentTermsText: Text[100];
//         dueDate: Date;
//         vendor: Record Vendor;
//         paymentTerm: Record "Payment Terms";
//         buyFromVendorNo: Code[100];
//         payerUrgement: Boolean;
//         montantCFA: Decimal;
//         paramettreComptable: Record 98;
//         echeanceEnJour: Integer;
//         dateFacturation: Date;
//         delaiExpiration: Integer;
//         Avance: Decimal;
//         viewDateOnRepport: Boolean;


// }