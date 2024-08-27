page 70093 "Transfert de stock"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 70026;

    layout
    {
        area(Content)
        {
            group("Général")
            {
                field("No."; rec."No.")
                {
                    Caption = 'N°';
                    Editable = false;
                }
                field("Document Date"; rec."Document Date")
                {
                    Editable = false;
                    Caption = 'Date de document';
                }
                field("Posting Date"; rec."Posting Date")
                {
                    Editable = false;
                    Caption = 'Date de comptabilisation';
                }
            }
            group("Article")
            {
                field("Item No."; rec."Item No.")
                {
                    Caption = 'N° Article';
                    trigger OnValidate()
                    var
                        item: record Item;
                        achetes: Integer;
                        vendu: Integer;
                        stock: Integer;
                    begin
                        // item.SetRange(loc, '%1', rec."Location Code");
                        item.SetRange("No.", rec."Item No.");
                        if item.FindFirst() then begin
                            item.CalcFields("Cartons achetés");
                            item.CalcFields("Cartons vendus");
                            achetes := -item."Cartons achetés";
                            vendu := item."Cartons vendus";
                            stock := -(item."Cartons achetés" + item."Cartons vendus");
                            item."Nombre cartons" := stock;
                            rec.Description := item.Description;
                            item.CalcFields("Cartons Solde");
                            rec."curr Carton" := item."Cartons Solde";
                            item.CalcFields(Inventory);
                            rec."curr Quantity" := item.Inventory;
                            rec."curr Carton Mag" := item.ItemCartonStokbyMagasin(rec."Location Code");
                            rec."curr Quantity Mag" := item.ItemQuantityStockbyMagasin(rec."Location Code");
                        end;
                    end;


                }
                field(Description; rec.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                }
                field("curr Carton"; rec."curr Carton")
                {
                    Caption = 'Cartons total';
                    Style = Favorable;
                }
                field("curr Quantity"; rec."curr Quantity")
                {
                    Caption = 'Quantité total';
                    Style = Favorable;
                    DecimalPlaces = 0 : 3;
                }
            }
            group(MAgasin)
            {
                ShowCaption = false;
                group(Origine)
                {
                    field("Location Code"; rec."Location Code")
                    {
                        Caption = 'Code magasin';
                        ShowMandatory = true;
                        Style = Unfavorable;


                        trigger OnValidate()
                        var
                            item: record Item;
                            achetes: Integer;
                            vendu: Integer;
                            stock: Integer;
                        begin
                            // item.SetRange(loc, '%1', rec."Location Code");
                            item.SetRange("No.", rec."Item No.");
                            if item.FindFirst() then begin
                                item.CalcFields("Cartons achetés");
                                item.CalcFields("Cartons vendus");
                                achetes := -item."Cartons achetés";
                                vendu := item."Cartons vendus";
                                stock := -(item."Cartons achetés" + item."Cartons vendus");
                                item."Nombre cartons" := stock;
                                rec.Description := item.Description;
                                item.CalcFields("Cartons Solde");
                                rec."curr Carton" := item."Cartons Solde";
                                item.CalcFields(Inventory);
                                rec."curr Quantity" := item.Inventory;
                                rec."curr Carton Mag" := item.ItemCartonStokbyMagasin(rec."Location Code");
                                rec."curr Quantity Mag" := item.ItemQuantityStockbyMagasin(rec."Location Code");
                            end;
                        end;

                    }
                    field("curr Carton Mag"; rec."curr Carton Mag")
                    {
                        // Caption = 'Cartons total';
                        Style = Strong;
                    }
                    field("curr Quantity Mag"; rec."curr Quantity Mag")
                    {
                        // Caption = 'Quantité total';
                        Style = Strong;
                        DecimalPlaces = 0 : 3;
                    }



                }

                group(Destination)
                {
                    field("Location CodeDest"; rec."Location CodeDest")
                    {
                        Caption = 'Code magasin';
                        ShowMandatory = true;
                        Style = Favorable;


                        trigger OnValidate()
                        var
                            item: record Item;
                            achetes: Integer;
                            vendu: Integer;
                            stock: Integer;
                        begin
                            // item.SetRange(loc, '%1', rec."Location Code");
                            item.SetRange("No.", rec."Item No.");
                            if item.FindFirst() then begin
                                item.CalcFields("Cartons achetés");
                                item.CalcFields("Cartons vendus");
                                achetes := -item."Cartons achetés";
                                vendu := item."Cartons vendus";
                                stock := -(item."Cartons achetés" + item."Cartons vendus");
                                item."Nombre cartons" := stock;
                                rec.Description := item.Description;
                                item.CalcFields("Cartons Solde");
                                rec."curr Carton" := item."Cartons Solde";
                                item.CalcFields(Inventory);
                                rec."curr Quantity" := item.Inventory;
                                rec."curr Carton Mag dest" := item.ItemCartonStokbyMagasin(rec."Location CodeDest");
                                rec."curr Quantity Mag dest" := item.ItemQuantityStockbyMagasin(rec."Location CodeDest");
                            end;
                        end;

                    }
                    field("curr Carton Mag dest"; rec."curr Carton Mag dest")
                    {
                        // Caption = 'Cartons total';
                        Style = Strong;
                    }
                    field("curr Quantity Mag dest"; rec."curr Quantity Mag dest")
                    {
                        // Caption = 'Quantité total';
                        Style = Strong;
                        DecimalPlaces = 0 : 3;
                    }



                }
            }
            group("Transfert")
            {
                field(Type; rec.Type)
                {
                    Caption = 'Type';
                    Visible = false;
                }

                field("Nombre Cartons"; rec."Nombre Cartons")// carton ajustement
                {
                    Caption = 'Nombre de cartons'; //Style =
                    BlankZero = true;
                }
                field("Quantité"; rec."Quantité") // Qutantité ajustement
                {
                    DecimalPlaces = 0 : 3;
                    Caption = 'Poids';
                    BlankZero = true;
                }
            }
        }
    }

    actions
    {
        
        area(Processing)
        {
            action("Valider Transfert")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PostDocument;
                Enabled = NOT rec.Posted;
                trigger OnAction()
                var
                    itemJournal: record 83;
                    xitemJournal: record 83;
                    yitemJournal: record 83;
                    pesée: Record Pesse;
                    pesée2: Record Pesse;
                    ecritureCarton: record "Ecriture cartons articles";
                    ecritureCarton2: record "Ecriture cartons articles";
                    usersep: Record "User Setup";
                    articl: Record Item;
                begin
                    usersep.get(UserId);
                    if not usersep.ValiderTransfert then
                        Error('Vous n''est pas autorisé à realiser cette action');
                    rec.TestField("Location Code");
                    rec.TestField("Location CodeDest");
                    yitemJournal.Reset();
                    yitemJournal.setRange("Journal Template Name", 'ARTICLE');
                    yitemJournal.setRange("Journal Batch Name", 'TULIPE');
                    if yitemJournal.FindFirst() then
                        yitemJournal.DeleteAll();
                    if rec."Quantité" <> 0 then begin
                        //Block code addedby Smart Fabrice

                        if rec."curr Carton Mag" < 0 then begin
                            Error('Le stock disponible n''est pas suffisant');
                        end;
                        if rec."curr Carton" < 0 then begin
                            Error('Le nombre de cartons disponibles est insuffisants');
                        end;
                        if (rec."Nombre Cartons" < 0) OR (rec."Nombre Cartons" > rec."curr Carton") then begin
                            Error('le nombre de cartons saisi n''est pas correct');
                        end;
                        if (rec."Quantité" > rec."curr Quantity Mag") then begin
                            Error('le poids saisi est incorrect');
                        end;
                        // if (rec.) then begin

                        // end;

                        //Retrait du stock
                        itemJournal.Reset();
                        itemJournal.Init();

                        itemJournal."Journal Template Name" := 'ARTICLE';
                        itemJournal."Journal Batch Name" := 'TULIPE';
                        itemJournal."Posting Date" := WorkDate();
                        itemJournal.Validate("Posting Date");
                        itemJournal."Entry Type" := itemJournal."Entry Type"::"Negative Adjmt.";
                        itemJournal.Quantity := rec."Quantité";
                        itemJournal."Nombre de carton" := rec."Nombre Cartons";
                        itemJournal.Validate("Entry Type");
                        itemJournal."Line No." := 10000;
                        itemJournal.Validate("Line No.");
                        itemJournal."Document No." := rec."No.";
                        itemJournal.Validate("Document No.");
                        itemJournal."Item No." := rec."Item No.";
                        articl.Reset();
                        articl.SetRange("No.", rec."Item No.");
                        if articl.FindFirst() then begin
                            itemJournal."Gen. Prod. Posting Group" := articl."Gen. Prod. Posting Group";


                        end;
                        itemJournal.Validate("Gen. Prod. Posting Group");

                        itemJournal.Validate("Item No.");
                        itemJournal."Location Code" := rec."Location Code";
                        itemJournal.Validate(Quantity);
                        itemJournal.Insert();

                        "pesée".Reset();
                        "pesée"."Document No." := rec."No." + '-TRS';
                        "pesée"."Document Type" := "pesée"."Document Type"::Order;
                        "pesée".nombre := 0/* - (rec."curr Carton")*/;
                        "pesée"."No." := rec."Item No.";
                        "pesée".Valid := true;
                        "pesée".verif := false;
                        "pesée"."Line No." := 10000;
                        "pesée".Num += 1;
                        "pesée".facture := true;
                        "pesée"."Location Code" := rec."Location Code";
                        "pesée".Insert();
                        //---- Separator ----//
                        clear("ecritureCarton");
                        ecritureCarton."Posting date" := WorkDate();
                        "ecritureCarton"."Document No" := rec."No." + '-TRS';
                        "ecritureCarton"."Document Type" := "ecritureCarton"."Document Type"::"Ajustement Negatif";
                        "ecritureCarton"."Item No" := rec."Item No.";
                        "ecritureCarton"."Nombre de carton" := 0;
                        ecritureCarton.Poids := 0;
                        ecritureCarton."Location Code" := rec."Location Code";
                        "ecritureCarton".Insert(true);




                        //Ajout du stock
                        itemJournal.Reset();
                        itemJournal.Init();

                        itemJournal."Journal Template Name" := 'ARTICLE';
                        itemJournal."Journal Batch Name" := 'TULIPE';
                        itemJournal."Posting Date" := WorkDate();
                        itemJournal.Validate("Posting Date");
                        itemJournal."Line No." := 20000;
                        itemJournal.Validate("Line No.");
                        itemJournal."Entry Type" := itemJournal."Entry Type"::"Positive Adjmt.";
                        itemJournal.Quantity := rec."Quantité";
                        itemJournal."Nombre de carton" := rec."Nombre Cartons";
                        itemJournal.Validate("Entry Type");
                        itemJournal."Document No." := rec."No.";
                        itemJournal.Validate("Document No.");
                        itemJournal."Item No." := rec."Item No.";


                        itemJournal.Validate("Item No.");


                        articl.Reset();
                        articl.SetRange("No.", rec."Item No.");
                        if articl.FindFirst() then begin
                            itemJournal."Gen. Prod. Posting Group" := articl."Gen. Prod. Posting Group";


                        end;
                        itemJournal.Validate("Gen. Prod. Posting Group");
                        itemJournal."Location Code" := rec."Location CodeDest";
                        itemJournal.Validate(Quantity);
                        itemJournal.Insert();



                        "pesée".Reset();
                        "pesée"."Document No." := rec."No." + '-TRS';
                        "pesée"."Document Type" := "pesée"."Document Type"::Receipt;
                        "pesée".nombre := 0/* - (rec."curr Carton")*/;
                        "pesée"."No." := rec."Item No.";
                        "pesée".Valid := true;
                        "pesée".verif := false;
                        "pesée"."Line No." := 20000;
                        "pesée".Num += 1;
                        "pesée".facture := true;
                        "pesée"."Location Code" := rec."Location CodeDest";
                        "pesée".Insert();
                        //---- Separator ----//
                        clear("ecritureCarton");
                        ecritureCarton."Posting date" := WorkDate();
                        "ecritureCarton"."Document No" := rec."No." + '-TRS';
                        "ecritureCarton"."Document Type" := "ecritureCarton"."Document Type"::"Ajustement Positif";
                        "ecritureCarton"."Item No" := rec."Item No.";
                        "ecritureCarton"."Nombre de carton" := 0;
                        ecritureCarton.Poids := 0;
                        ecritureCarton."Location Code" := rec."Location CodeDest";
                        "ecritureCarton".Insert(true);

                    end;





                    CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", itemJournal);
                    rec."Posting Date" := WorkDate();
                    rec.Posted := true;
                    CurrPage.Editable := false;
                    CurrPage.Close();
                end;





            }
            action("Feuilles Article")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ItemLedger;
                RunObject = Page 40;
                RunPageMode = View;
                Enabled = NOT rec.Posted;
            }
            
        }
        
    }

    var
        style: Option;


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        rec."Document Date" := WorkDate();
        // rec."Location Code" := 'SIEGE';
    end;

    trigger OnAftergetrecord()
    var
        myInt: Integer;
    begin
        if rec.Type = rec.Type::Negatif then begin

        end;

    end;

    trigger OnOpenPage()
    var
        item: record Item;
    begin
        rec.Type := rec.Type::Inventaire;
        item.SetRange("No.", rec."Item No.");
        if item.FindFirst() then begin
            rec.Description := item.Description;
            rec."curr Carton" := item."Cartons Solde";
            item.CalcFields(Inventory);
            rec."curr Quantity" := item.Inventory;
            if rec.Posted then
                CurrPage.Editable := false;
        end;
    end;
}