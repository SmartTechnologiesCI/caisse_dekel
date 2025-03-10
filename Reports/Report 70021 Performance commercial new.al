report 70021 PerformanceCommercialNew
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Reports\RDLC\Report 70021 Performance commercial new.rdlc';
    Caption = 'Performance commercial detail';

    dataset
    {

        dataitem("Team Salesperson"; "Team Salesperson")
        {
            column(Salesperson_Code; "Salesperson Code") { }
            column(Utilisateur; Utilisateur) { }
            column(date_Debut; date_Debut) { }
            column(date_Fin; date_Fin) { }

            dataitem("Objectif Commercial"; "Objectif Commercial")
            {

                DataItemLink = groupe = field("Team Code");
                column(No; No) { }
                column(Groupe; Groupe) { }

                column(tailleGroupe; tailleGroupe) { }




                dataitem("Ligne Ojectif Commercial"; "Ligne Ojectif Commercial")
                {

                    DataItemLink = "No Task" = field(No);
                    // RequestFilterFields = "Date debut";

                    column(No_Article; "No Article") { }
                    column(No_Task; "No Task") { }
                    column(Description; "Description")
                    {

                    }
                    column(Qte_Poids; "Qte Poids")
                    {

                    }
                    column(qteVendue; qteVendue) { }
                    column(performance; performance) { }
                    column(bonus; bonus) { }
                    column(Prime; Prime) { }
                    column(primeBonus; primeBonus) { }



                    trigger OnPreDataItem()
                    var
                        myInt: Integer;

                    begin
                        SetRange("Date debut", date_Debut, date_Fin);

                    end;

                    trigger OnAfterGetRecord()
                    var
                        myInt: Integer;
                        // silue samuel 07/03/2025 sil: Record "Sales Invoice Line";
                        sih: Record "Sales Invoice Header";
                        groupe: Record "Team Salesperson";
                        objectifComm: Record "Objectif Commercial";
                        ligneObjectif: Record "Ligne Ojectif Commercial";
                        itemCat: Record "Item Category";
                    begin




                        montantPrime := Prime / taille_Groupe;
                        qteVendue := 0;

                        sih.Reset();
                        if sih.FindFirst() then;
                        sih.CalcFields(Cancelled);
                        sih.SetRange("Salesperson Code", "Team Salesperson".Utilisateur);
                        sih.SetFilter("Posting Date", '%1..%2', date_Debut, date_Fin);
                        sih.SetRange(Cancelled, false);
                        if sih.FindFirst() then begin
                            // silue samuel 07/03/2025 repeat
                            //     sil.Reset();
                            //     sil.SetRange("Document No.", sih."No.");
                            //     sil.SetRange("Posting Date", "Ligne Ojectif Commercial"."Date debut");
                            //     if TypeLigne = TypeLigne::Article then begin
                            //         sil.SetRange("No.", "Ligne Ojectif Commercial"."No Article");
                            //     end else
                            //         sil.SetRange("Item Category Code", "Ligne Ojectif Commercial"."No Article");

                            //     if sil.FindFirst() then begin
                            //         repeat
                            //             if sil.Quantity = 0 then CurrReport.Skip();
                            //             qteVendue := qteVendue + sil.Quantity;
                            //         until sil.Next() = 0;
                            //     end;
                            //fin silue samuel 07/03/2025 until sih.Next = 0;
                        end;


                        /*    if TypeLigne = TypeLigne::Categorie then begin

                               if sih.FindFirst() then begin
                                   repeat
                                       sil.Reset();
                                       sil.SetRange("Document No.", sih."No.");
                                             if itemCat.FindFirst() then begin
                                                repeat

                                                    sil.SetRange("Item Category Code", itemCat.Code);
                                                    if sil.FindFirst() then begin
                                                        repeat
                                                            qteVendue := qteVendue + sil.Quantity;
                                                        until sil.Next() = 0;
                                                    end;
                                                until itemCat.Next = 0;

                                            end; 

                                        if sil.FindFirst() then begin
                                           repeat
                                               //itemCat.SetRange(Code,sil."Item Category Code");
                                               if itemCat.Get(sil."Item Category Code") then begin
                                                   if itemCat.Code = "Ligne Ojectif Commercial"."No Article" then
                                                       qteVendue := qteVendue + sil.Quantity;
                                               end;


                                           until sil.Next() = 0;
                                       end; 
                                   until sih.Next() = 0;
                               end;
                           end; */

                        //performance := qteVendue * 100 / ("Qte Poids" / taille_Groupe);
                        // performance := qteVendue / ("Qte Poids" / taille_Groupe);
                        performance := qteVendue / ("Qte Poids" / taille_Groupe);
                        if qteVendue >= "Qte Poids" then begin
                            bonus := (qteVendue * montantPrime) / "Qte Poids";
                            primeBonus := (montantPrime) * (performance);
                        end else begin
                            bonus := 0;
                            primeBonus := 0;
                        end;

                    end;






                }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                    DDebut: Date;
                    DFin: Date;
                begin
                    /*  DDebut := DMY2Date(01, DATE2DMY(date_Debut, 2), DATE2DMY(date_Debut, 3));
                     DFin := CalcDate('+1M -1J', DMY2Date(01, DATE2DMY(date_Fin, 2), DATE2DMY(date_Fin, 3)));
                     SetFilter(DateDebut, '>=%1', DDebut);
                     SetFilter(DateFin, '<=%1', DFin); */
                    SetFilter("Type de groupe", '=%1', "Type de groupe"::Commercial);





                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                    DDebut: Date;
                    DFin: Date;
                    ligneObjectif: Record "Ligne Ojectif Commercial";

                begin
                    CalcFields(tailleGroupe);
                    taille_Groupe := tailleGroupe;
                    //Inno 21-05-2020 Correction objectif vierge
                    ligneObjectif.SetRange("No Task", "Objectif Commercial".No);
                    ligneObjectif.SetRange("Date debut", date_Debut, date_Fin);
                    if not ligneObjectif.FindFirst() then CurrReport.Skip();

                end;


            }


            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                // silue samuel 07/03/2025 sil: Record "Sales Invoice Line";
                sih: Record "Sales Invoice Header";
                groupe: Record "Team Salesperson";
                objectifComm: Record "Objectif Commercial";
                ligneObjectif: Record "Ligne Ojectif Commercial";
                primeG: Decimal;
            begin


            end;
        }







    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Periode)
                {
                    field(date_Debut; date_Debut)
                    {
                        Caption = 'Debut';
                    }
                    field(date_Fin; date_Fin)
                    {
                        Caption = 'Fin';
                    }




                }

            }
        }




        actions
        {
            area(processing)
            {

                action("Envoyer par mail")
                {

                    ApplicationArea = All;
                    Caption = 'Envoyez Mail (No error)';
                    trigger OnAction()
                    var
                        myInt: Integer;
                        EmailItem: Record "Email Item" temporary;
                        RecRef: RecordRef;
                        OutStr: OutStream;
                        InStr: InStream;
                        BodyTxt: Text;
                        EmailMessage: Codeunit "Email Message";
                        tempBlob: Codeunit "Temp Blob";
                        AttachmentInStream: InStream;
                        Email: Codeunit Email;
                        Recipients: List of [Text];


                    //smtpMail: Codeunit "SMTP Mail";



                    begin

                        EmailMessage.Create(EmailReceveur, 'Performance Commercial', 'Performance commercial du mois');
                        Report.SaveAs(Report::PerformanceCommercial, 'Performance Commercial %1' + Format(WorkDate()), ReportFormat::Pdf, OutStr, RecRef);
                        tempBlob.CreateInStream(InStr);
                        EmailMessage.AddAttachment('Performance Commercial %1' + Format(WorkDate()), 'PDF', InStr);
                        Email.Send(EmailMessage);

                    end;
                }
            }


        }

        trigger OnOpenPage()
        var
            myInt: Integer;
        begin
            date_Debut := DMY2Date(01, DATE2DMY(WorkDate, 2), DATE2DMY(WorkDate, 3));
            date_Fin := CalcDate('+1M -1J', DMY2Date(01, DATE2DMY(WorkDate, 2), DATE2DMY(WorkDate, 3)));
            EmailReceveur := 'ikacou@smartechnologies.com';

        end;

    }


    var
        commercial: Text[50];
        myInt: Integer;
        date_Debut: Date;
        date_Fin: Date;
        objectifCom: Record "Objectif Commercial";
        performance: Decimal;
        performanceParPersonne: Decimal;
        bonus: Decimal;
        montantPrime: Decimal;

        ekip: Record Team;
        // utilisateur: Code[50];
        qteVendue: Decimal;

        // teamSalesPerson: Record "Team Salesperson";
        userSetup: Record "User Setup";

        salesIvoiceHeader: Record "Sales Invoice Header";
        // articleVendu: Record item;
        taille_Groupe: Decimal;
        EmailReceveur: Text;
        primeBonus: Decimal;
        jour: Date;

}